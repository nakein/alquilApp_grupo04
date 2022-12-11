class PenaltiesController < ApplicationController
    def index
        @penalties = Penalty.all
    end

    def new
        $report_local = Report.find(params[:format])
    end
    
    def show
        @penalty = Penalty.find(params[:id])
    end
    
    def edit
        @penalty = Penalty.find(params[:id])
    end
    
    def update
        @penalty = Penalty.find(params[:id])
    
        if @usuario.update(penalties_params)
          redirect_to reports_path, notice: "El usuario fue actualizado"
        end
    end
    
    def create
        @penalty = Penalty.new(penalties_params)
    
        if @penalty.save
            $report_local.status = 1
            $report_local.save
            @billetera_local = Usuario.find(@penalty.usuario_id).billetera
            @multa = @penalty.tarifa.to_f
            @billetera_local.saldo = @billetera_local.saldo - @multa
            @billetera_local.save

            redirect_to reports_path, notice: "Reporte resuelto satisfactoriamente"
        else
            render 'new'
        end
    end

    private

        def penalties_params
            params.require(:penalty).permit(:motivo, :descripcion, :tarifa, :usuario_id);
        end


end