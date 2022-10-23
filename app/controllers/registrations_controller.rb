class RegistrationsController < Devise::RegistrationsController

    def index
        @clientes = Cliente.all
    end
    
    def show
        @cliente = Cliente.find(params[:id])
     end
    
    def edit
        @cliente = Cliente.find(params[:id])
    end
    
    def update
        @cliente = Cliente.find(params[:id])
    
        if @cliente.update(register_params)
          redirect_to clientes_path, notice: "El cliente fue actualizado"
    end
    
    def create
        @cliente = Cliente.new(register_params)
    
        if @cliente.save
          redirect_to @cliente, notice: "Cliente agregado"
    end

    private

        def register_params
            params.require(:cliente).permit(:fullname, :dni, :birthdate, :license, :email, :password, :password_confirmation);
        end

end
