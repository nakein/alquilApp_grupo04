class AlquilersController < ApplicationController

    def show
        @vehiculo = Vehiculo.find(params[:id])
    end

    def create
        @alquiler = Alquiler.new(alquiler_params)
        @alquiler.user_id = current_usuario.id
        @alquiler.vehicle_id = params[:vehicle_id]
        
        if @alquiler.save
            redirect_to root_path, notice: "Alquiler creado satisfactoriamente"
        else
            render 'show'
        end
    end

    private

        def alquiler_params
            params.require(:alquiler).permit(:hours);
        end
end
