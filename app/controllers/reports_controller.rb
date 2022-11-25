class ReportsController < ApplicationController
    $r_order = 0;

    def index
        if (current_usuario.supervisor?)
            @reports = Report.order(sort_column + ' ' + sort_direction)
        elsif (current_usuario.cliente?)
            @reports=Report.where(usuario_id:current_usuario.id)
        end
    end

    def new
    end

    def create
        @report = Report.new(report_params)
        @report.usuario_id = current_usuario.id
        
        if @report.save
            redirect_to root_path, notice: "Reporte enviado con éxito"
        else
            render 'new'
        end
    end

    def show
        @report = Report.find(params[:id])
    end

    def edit
    end

    def update
        @report = Report.find(params[:id])
        
        if ( @report.status == "esperando" )
            @report.status = 1
        end
        @report.save
        redirect_to reports_path, notice: "Se ha cambiado el estado del reporte"
        
    end

    def destroy
    end

    private
        
    def sort_column
        params[:sort] || "id"
    end

    def sort_direction
        params[:direction] || "asc"
    end

    def report_params
        params.require(:report).permit(:subject, :message, :status, :usuario_id);
    end
end
