class StatsController < ApplicationController

    def autos
    end



    def usuarios
        @usuarios=Usuario.where(role:0)
        @horas_total={}
        @tiempo_dias_total={}
        Usuario.where(role:0).each do |usuario|
            @horas_total_usuario= 0
            Alquiler.where(user_id: usuario.id).each do |alqui|
                @horas_total_usuario = @horas_total_usuario + alqui.hours 
            end
            @tiempo_dias_total["#{usuario.id}"]=((DateTime.now.utc - usuario.created_at.utc)/86400).to_int
            @horas_total["#{usuario.id}"]=@horas_total_usuario
        end
    end

end