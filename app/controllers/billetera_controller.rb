require 'mercadopago.rb'
class BilleteraController < ApplicationController
    
    def index 
    end

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
   #     if(@compra.medio_de_pago == 'Mercado Pago')

            require 'mercadopago'


            #Se carga el Access Token de la aplicacion
            sdk = Mercadopago::SDK.new('APP_USR-2607182082531809-110514-d7f351aaede87c03c0b222130279be1f-686347249')

            customer_request = {
            email: 'john@yourdomain.com'
            }
            customer_response = sdk.customer.create(customer_request)
            customer = customer_response[:response]

            card_request = {
            token: '9b2d63e00d66a8c721607214cedaecda',
            issuer_id: '3245612',
            payment_method_id: 'debit_card'
            }
            card_response = sdk.card.create(customer['id'], card_request)
            card = card_response[:response]

            payment_data = {
            transaction_amount: @compra.monto,
            token: card_response,
            description: 'Payment description',
            payment_method_id: 'visa',
            installments: 1,
            payer: {
                email: 'joaquin.stella@alu.ing.unlp.edu.ar'
           }
           }
            result = sdk.payment.create(payment_data)
            payment = result[:response]

        puts payment
        
     #   end
         current_usuario.billetera.saldo = current_usuario.billetera.saldo + @compra.monto
         current_usuario.billetera.save
         redirect_to '/billetera/mi_billetera' and return
    end

    def show
        render "mi_billetera"
    end

end
