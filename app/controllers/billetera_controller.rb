class BilleteraController < ApplicationController
    def mi_billetera
        billeteraActual = current_usuario.billetera
    end

    def get
    end

    def cargar_creditos
         billeteraActual = current_usuario.billetera
         billeteraActual.saldo = billeteraActual.saldo + 10.0
         billeteraActual.save
         render "mi_billetera"
    end

    def show
        carga = 0.0
        #carga representa el monto elegido para cargar en la billetera
        render "mi_billetera"
    end

end
