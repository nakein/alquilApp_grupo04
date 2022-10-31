class BilleteraController < ApplicationController
    def mi_billetera
        billeteraActual = current_usuario.billetera
    end

    def get
    end

    def cargar_creditos
         current_usuario.billetera.saldo = current_usuario.billetera.saldo + 10.0
         current_usuario.billetera.save
         redirect_to '/billetera/mi_billetera' and return
    end

    def show
        carga = 0.0
        #carga representa el monto elegido para cargar en la billetera
        render "mi_billetera"
    end

end
