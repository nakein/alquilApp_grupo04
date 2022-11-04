class BilleteraController < ApplicationController
    def mi_billetera
    end

    def get
    end

    def cargar_creditos
        @compra = Compra.new(medio_de_pago: params.require(:medio_de_pago), datos_cuenta: params.require(:datos_cuenta),monto: params.require(:monto))
        @compra.save
        if(current_usuario.billetera.compra != nil)
            current_usuario.billetera.compra.destroy
        end
        current_usuario.billetera.compra = @compra
         current_usuario.billetera.saldo = current_usuario.billetera.saldo + @compra.monto
         current_usuario.billetera.save
         redirect_to '/billetera/mi_billetera' and return
    end

    def show
        render "mi_billetera"
    end

end
