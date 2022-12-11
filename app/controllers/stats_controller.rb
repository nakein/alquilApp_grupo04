class StatsController < ApplicationController

    def autos
    end



    def usuarios
        @usuarios=Usuario.where(role:0)
        @horas_total={}
        Usuario.where(role:0).each do |usuario|
            @horas_total_usuario= 0
            Alquiler.where(user_id: usuario.id).each do |alqui|
                @horas_total_usuario = @horas_total_usuario + alqui.hours 
            end
            @horas_total["#{usuario.id}"]=@horas_total_usuario
        end
    end

end