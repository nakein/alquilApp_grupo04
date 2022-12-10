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
        for i in 1..current_usuario.billetera.cards.length
            @medios_de_pago_disponibles[i] = current_usuario.billetera.cards[i-1].name;
        end;
        for i in 1..current_usuario.billetera.cvus.length
            @medios_de_pago_disponibles[@medios_de_pago_disponibles.length] = current_usuario.billetera.cvus[i-1].name;
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

    def medios_pago
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
        elsif (current_usuario.billetera.cvus.where(name: @compra.medio_de_pago).exists?)
            current_cvu = Card.find(current_usuario.billetera.cvus.where(name: @compra.medio_de_pago).ids[0]);
            if(current_cvu.money < @compra.monto)
                show_info = "La carga de créditos no se pudo realizar porque no tiene fondos suficientes";
            else   
                current_cvu.update(money: current_cvu.money - @compra.monto);
                current_usuario.billetera.saldo = current_usuario.billetera.saldo + @compra.monto;
                current_usuario.billetera.save;
                show_info = "La carga de créditos fue realizada exitosamente";
            end
        elsif (current_usuario.billetera.cards.where(name: @compra.medio_de_pago).exists?)
            current_card = Card.find(current_usuario.billetera.cards.where(name: @compra.medio_de_pago).ids[0]);
            if(current_card.exp_date < DateTime.now)
                show_info = "La carga de créditos no se pudo realizar porque su tarjeta ha expirado";
            elsif(current_card.money < @compra.monto)
                show_info = "La carga de créditos no se pudo realizar porque no tiene fondos suficientes";
            else   
                current_card.update(money: current_card.money - @compra.monto);
                current_usuario.billetera.saldo = current_usuario.billetera.saldo + @compra.monto;
                current_usuario.billetera.save;
                 show_info = "La carga de créditos fue realizada exitosamente";
            end
        end;
        redirect_to '/billetera/mi_billetera', notice: show_info and return
    end

    def show
        render "mi_billetera"
    end

    def agregar_card
        @tarjeta = Card.new(id: current_usuario.billetera.cards.count+1,name: params.require(:name),digits: params.require(:digits),security_code: params.require(:security_code),exp_date: params.require(:exp_date),money: 1000.0,billetera_id: current_usuario.billetera.id,card_type: params.require(:card_type));
        if(!card_digits_exists(@tarjeta.digits,@tarjeta.card_type))
            show_info = "No se ha podido encontrar una tarjeta que coincida con los datos ingresados";
        elsif(!is_card_available(@tarjeta.digits))
            show_info = "La tarjeta ingresada se encuentra inhabilitada";
        elsif(@tarjeta.exp_date < DateTime.now)
            show_info = "La carga de créditos no se pudo realizar porque su tarjeta ha expirado";
        else
            wallet = current_usuario.billetera;
            wallet.card_ids[wallet.cards.count] = @tarjeta.id;
            wallet.save;
            @tarjeta.save;
            show_info = "Se ha agregado una nueva tarjeta correctamente";
        end;
        redirect_to '/billetera/medios_pago', notice: show_info and return
    end

    def destroy_card
       
        @tarjeta = Card.find(params[:id]);
        @tarjeta.destroy;

        redirect_to '/billetera/medios_pago', notice: "Tarjeta eliminada satisfactoriamente" and return
    end

    def new_cvu
    end

    def agregar_cvu
        
        @cvu = Cvu.new(id: current_usuario.billetera.cvus.count+1,name: params.require(:name),digits: params.require(:digits),alias: params.require(:alias),money: 1000.0,billetera_id: current_usuario.billetera.id);
        
        if(!cvu_digits_exists(@cvu.digits))
            show_info = "No se ha podido encontrar un CVU que coincida con los datos ingresados";
        elsif(!is_cvu_available(@cvu.digits))
            show_info = "El CVU ingresado se encuentra inhabilitado";
        elsif(!cvu_digits_alias_match(@cvu.digits,@cvu.alias))  
            show_info = "Los digitos del CVU no corresponden a la cuenta del alias ingresado";
        else
            wallet = current_usuario.billetera;
            wallet.card_ids[wallet.cvus.count] = @cvu.id;
            wallet.save;
            @cvu.save;
            show_info = "Se ha agregado un nuevo CVU correctamente";
        end;
        redirect_to '/billetera/medios_pago', notice: show_info and return
    end

    def destroy_cvu

        @cvu = Cvu.find(params[:id]);
        @cvu.destroy;

        redirect_to '/billetera/medios_pago', notice: "CVU eliminado satisfactoriamente" and return
    end

    private
        def ejemplos_tarjeta
            tarjeta1 = Card.new(id: 1, name: "Tarjeta Naranja", digits: "01234567890123456789", security_code: "123", exp_date: DateTime.new(2022,12,5), money: 50.0, card_type: "debito");                                    
            tarjeta2 = Card.new(id: 2, name: "Uala", digits: "01234567899876543210", security_code: "234", exp_date: DateTime.new(2022,10,5.5), money: 3200.0, card_type: "visa");
            tarjeta3 = Card.new(id: 3, name: "Mastercard Black", digits: "11223344556677889900", security_code: "456", exp_date: DateTime.new(2022,12,30), money: 12000.0, card_type: "mastercard");
            tarjeta1.save;
            tarjeta2.save;
            tarjeta3.save;
        end

        def card_digits_exists(digits,card_type)
            i = 0;
            invalid_digits = ["00112233445566778899"];
            while ((i < (invalid_digits.length-1)) && (digits != invalid_digits[i]))
                i = i+1
            end;
            return (digits != invalid_digits[i])&&!((card_type == 'visa')&&(digits[0] != '4'))&&!((card_type == 'mastercard')&&(digits[0] != '5'));
        end

        def is_card_available(digits)
            i = 0;
            unavailable_digits = ["11223344556677889900"];
            while ((i < (unavailable_digits.length-1)) && (digits == unavailable_digits[i]))
                i = i+1
            end;
            return (digits != unavailable_digits[i]);
        end   
        
        def cvu_digits_exists(digits)
            i = 0;
            invalid_digits = ["0011223344556677889911"];
            while ((i < (invalid_digits.length-1)) && (digits != invalid_digits[i]))
                i = i+1
            end;
            return (digits != invalid_digits[i]);
        end

        def is_cvu_available(digits)
            i = 0;
            unavailable_digits = ["1122334455667788990011"];
            while ((i < (unavailable_digits.length-1)) && (digits != unavailable_digits[i]))
                i = i+1
            end;
            return (digits != unavailable_digits[i]);
        end  

        def cvu_digits_alias_match(digits,alias_cvu)
            i = 0;
            invalid_alias = ["prueba.uso.alquilapp"];
            while ((i < (invalid_alias.length-1)) && (alias_cvu != invalid_alias[i]))
                i = i+1
            end;
            return (alias_cvu != invalid_alias[i]);
        end

    end
