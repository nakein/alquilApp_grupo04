class ReportsController < ApplicationController
    
    def index
        if (current_usuario.supervisor?)
            @reports=Report.all
        else
            @reports=Report.where(usuario_id:params[:id])
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
    
        if @report.update(report_params)
          redirect_to root_path, notice: "Se ha cambiado el estado del reporte"
        else
            render :edit
        end
    end

    def destroy
    end

    private
        
    def report_params
        params.require(:report).permit(:subject, :message, :status);
    end
end
