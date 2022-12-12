class StatsController < ApplicationController

    def vehiculos
        @alquileres=Alquiler.all
        @vehiculos=Vehiculo.all
        @horarios={}
        @tabla_hash={}
        Vehiculo.all.each do |vehiculo|
            for a in 8..19 do
                @horarios["#{a}"]= 0
            end
            @tabla_hash["#{vehiculo.id}"]=@horarios
        end
        Alquiler.all.each do |alqui|
            @horarios=8
            if((alqui.created_at.hour >= 8) && (alqui.created_at.hour <=19))
                @limit_inf=alqui.created_at.hour
            else
                @limit_inf=8
            end

            if((alqui.updated_at.hour >= 8) && (alqui.updated_at.hour <=8))
                @limit_sup=alqui.created_at.hour
            else
                @limit_sup=19
            end

            if((@limit_inf == 8) && (@limit_sup == 19) && (!(alqui.hours >= 12 )) )
                @limit_inf=0
                @limit_sup=0
            end
            
            if(!(@limit_inf == 0))
                for a in @limit_inf..@limit_sup do
                    @tabla_hash["#{alqui.vehicle_id}"]["#{a}"] = @tabla_hash["#{alqui.vehicle_id}"]["#{a}"] + 1
                end
            end
        end
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