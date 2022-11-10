require 'mercadopago.rb'
class BilleteraController < ApplicationController
    
    def index 
    end

    def mi_billetera
        sdk = Mercadopago::SDK.new('TEST-2607182082531809-110514-4e42d4f234e94ea6cbf7101fa2c74ff2-686347249')

            # Crea un objeto de preferencia
            preference_data = {
            items: [
                {
                title: 'Mi producto',
                unit_price: 10,
                quantity: 1
                }
            ],
            purpose: 'wallet_purchase'
            }
            preference_response = sdk.preference.create(preference_data)
            preference = preference_response[:response]

            # Este valor substituirá a la string "<%= @preference_id %>" en tu HTML
            @preference_id = preference['id']
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
            sdk = Mercadopago::SDK.new('TEST-2607182082531809-110514-4e42d4f234e94ea6cbf7101fa2c74ff2-686347249')

            customer_request = {
            email: current_usuario.email
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
        
     #   end
         current_usuario.billetera.saldo = current_usuario.billetera.saldo + @compra.monto
         current_usuario.billetera.save
         redirect_to '/billetera/mi_billetera' and return
    end

    def show
        render "mi_billetera"
    end

end
