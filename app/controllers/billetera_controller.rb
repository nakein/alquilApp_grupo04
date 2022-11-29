require 'mercadopago.rb'
require 'date'
class BilleteraController < ApplicationController
    
    def index 
    end

    def mi_billetera
        if(Card.all.empty?)
            ejemplos_tarjeta;
        end;

        @medios_de_pago_disponibles = ["Elegir..."];
        for i in 1..Card.count
        @medios_de_pago_disponibles[i] = Card.find(i).name
        end;

     #   sdk = Mercadopago::SDK.new('TEST-2607182082531809-110514-4e42d4f234e94ea6cbf7101fa2c74ff2-686347249')

            # Crea un objeto de preferencia
     #       preference_data = {
     #       items: [
     #           {
     #           title: 'Mi producto',
     #           unit_price: 10,
     #           quantity: 1
     #           }
     #       ],
     #       purpose: 'wallet_purchase'
     #       }
     #       preference_response = sdk.preference.create(preference_data)
     #       preference = preference_response[:response]

            # Este valor substituirá a la string "<%= @preference_id %>" en tu HTML
      #      @preference_id = preference['id']
            @preference_id = 1;
    end

    def get
    end

    def cargar_creditos
        @compra = Compra.new(medio_de_pago: params.require(:medio_de_pago),monto: params.require(:monto))
        @compra.save
        if(current_usuario.billetera.compra != nil)
            current_usuario.billetera.compra.destroy
        end
        current_usuario.billetera.compra = @compra

        if(@compra.medio_de_pago == "Elegir...")
            show_info = "Escoja un medio de pago válido para cargar créditos";
        elsif (@compra.medio_de_pago == "Mercado Pago")

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
            current_usuario.billetera.saldo = current_usuario.billetera.saldo + @compra.monto
            current_usuario.billetera.save
            show_info = "La carga de créditos fue realizada exitosamente";
    #    elsif (current_usuario.billetera.cards.where(name: @compra.medio_de_pago).exists?)
    #        current_card = current_usuario.billetera.cards.where(name: @compra.medio_de_pago).ids[0];
    #        if(current_card.exp_date > DateTime.now)
    #            show_info = "La carga de créditos no se pudo realizar porque su tarjeta ha expirado";
    #        elsif(current_card.money < @compra.monto)
    #            show_info = "La carga de créditos no se pudo realizar porque no tiene fondos suficientes";
    #        else    
    #            current_usuario.billetera.saldo = current_usuario.billetera.saldo + @compra.monto
    #            current_usuario.billetera.save
    #             show_info = "La carga de créditos fue realizada exitosamente";
    #        end;
        elsif (Card.where(name: @compra.medio_de_pago).exists?)
            current_card = Card.find(Card.where(name: @compra.medio_de_pago).ids[0]);
            if(current_card.exp_date < DateTime.now)
                show_info = "La carga de créditos no se pudo realizar porque su tarjeta ha expirado";
            elsif(current_card.money < @compra.monto)
                show_info = "La carga de créditos no se pudo realizar porque no tiene fondos suficientes";
            else   
                current_card.update(money: current_card.money - @compra.monto);
                current_usuario.billetera.saldo = current_usuario.billetera.saldo + @compra.monto;
                current_usuario.billetera.save;
                 show_info = "La carga de créditos fue realizada exitosamente";
            end;
        end;
        redirect_to '/billetera/mi_billetera', notice: show_info and return
    end

    def show
        render "mi_billetera"
    end

    private
        def ejemplos_tarjeta
            tarjeta1 = Card.new(id: 1, name: "Tarjeta Naranja", digits: "01234567890123456789", security_code: "123", exp_date: DateTime.new(2022,12,5), money: 50.0, card_type: "debito");                                    
            tarjeta2 = Card.new(id: 2, name: "Uala", digits: "01234567899876543210", security_code: "234", exp_date: DateTime.new(2022,10,5.5), money: 3200.0, card_type: "visa");
            tarjeta3 = Card.new(id: 3, name: "Mastercard Black", digits: "11223344556677889900", security_code: "456", exp_date: DateTime.new(2022,11,30), money: 12000.0, card_type: "mastercard");
            tarjeta1.save;
            tarjeta2.save;
            tarjeta3.save;
        end


end
