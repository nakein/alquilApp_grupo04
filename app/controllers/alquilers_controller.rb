class AlquilersController < ApplicationController

    before_action :set_cache_headers

    def show
        @vehiculo = Vehiculo.find(params[:id])
    end

    def started
        @alquiler = Alquiler.where(user_id: current_usuario.id).last
        @vehiculo = Vehiculo.find(params[:id])
    end

    def finished
        @alquiler = Alquiler.where(user_id: current_usuario.id).last
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
        redirect_to root_path
    end

    def create
        @alquiler = Alquiler.new(alquiler_params)
        @alquiler.user_id = current_usuario.id
        @alquiler.vehicle_id = params[:vehicle_id]
        if ((current_usuario.billetera.saldo - 200*@alquiler.hours) >= 0)
            current_usuario.billetera.saldo = current_usuario.billetera.saldo - 200*@alquiler.hours
            current_usuario.billetera.save
            if @alquiler.save
                redirect_to started_alquiler_path(@alquiler.vehicle_id)
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
