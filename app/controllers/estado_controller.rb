class EstadoController < ApplicationController

    before_action :set_cache_headers

    def mi_estado
        @alquiler = Alquiler.where(user_id: current_usuario.id).last
        if(!@alquiler.nil?)
            @vehiculo = Vehiculo.find(@alquiler.vehicle_id)
        end
        render "mi_estado"
    end

end
