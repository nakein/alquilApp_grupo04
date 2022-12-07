class RatesController < ApplicationController

    def update
        @tarifa = Rate.find(1)
    
        if @tarifa.update(rate_params)
            redirect_to root_path, notice: "Los precios fueron actualizados"
        else
            redirect_to root_path, notice: "Ocurrió un error"
        end
    end

    private

    def rate_params
      params.require(:rate).permit(:rent_price, :extension_price, :penalty_price, :gas_price)
    end
end
