class AlquilersController < ApplicationController

    before_action :set_cache_headers


    def comprobar_estado
    end

    def show
        @vehiculo = Vehiculo.find(params[:id])
        @status = -1
        @alquiler = Alquiler.where(user_id: current_usuario.id).last
        if(!@alquiler.nil?)
            if(@alquiler.status == "en_curso")
                @status = 0
            elsif (@alquiler.status == "completado")
                @status = 1
            elsif (@alquiler.status == "cancelado")
                @status = 3
            end
        end
    end

    def update
        @alquiler = Alquiler.where(user_id: current_usuario.id).last
        if ((current_usuario.billetera.saldo - 250*(params[:alquiler][:hours]).to_i) >= 0)
            @alquiler.hours = @alquiler.hours + (params[:alquiler][:hours]).to_i
            @alquiler.save
            current_usuario.billetera.saldo = current_usuario.billetera.saldo - 250*@alquiler.hours
            current_usuario.billetera.save
            redirect_to estado_mi_estado_path, notice: "Tiempo extendido satisfactoriamente"
        else
            redirect_to estado_mi_estado_path, notice: "Fondos insuficientes"
        end
    end

    def finished
        @alquiler = Alquiler.where(user_id: current_usuario.id).last

        timeExtension = Time.now - (@alquiler.created_at + @alquiler.hours.hours)
        fine = (timeExtension/(15*60)).truncate()
        if (fine > 0)
            current_usuario.billetera.saldo = current_usuario.billetera.saldo - 100*fine
            current_usuario.billetera.save
        end

        #Acá va el código del attached de la imagen
        copy = @alquiler.dup
        copy.estado.attach(@alquiler.estado.blob)
        copy.nafta.attach(@alquiler.nafta.blob)
        
        @alquiler.status = 1
        @alquiler.save



        redirect_to root_path, notice: "Alquiler finalizado con exito"
    end

    def destroy
        @alquiler = Alquiler.where(user_id: current_usuario.id).last
        current_usuario.billetera.saldo = current_usuario.billetera.saldo + 200*@alquiler.hours
        current_usuario.billetera.save
        
        @alquiler.status = 3
        @alquiler.save
        redirect_to root_path, notice: "Alquiler cancelado. Se le devolverá su dinero"
    end

    def create
        @alquiler = Alquiler.new(alquiler_params)
        @alquiler.user_id = current_usuario.id
        @alquiler.vehicle_id = params[:vehicle_id]
        if ((current_usuario.billetera.saldo - 200*@alquiler.hours) >= 0)
            current_usuario.billetera.saldo = current_usuario.billetera.saldo - 200*@alquiler.hours
            current_usuario.billetera.save
            if @alquiler.save
                redirect_to estado_mi_estado_path
            end
        else
            redirect_to alquiler_path(@alquiler.vehicle_id), notice: "Fondos insuficientes"
        end
    end

    private

        def alquiler_params
            params.require(:alquiler).permit(:hours);
        end
end
