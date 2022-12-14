class RegistrationsController < Devise::RegistrationsController

    def index
        @usuarios = Usuario.all
    end
    
    def show
        @usuario = Usuario.find(params[:id])
    end
    
    def edit
        @usuario = Usuario.find(params[:id])
    end
    
    def update
        @usuario = Usuario.find(params[:id])
    
        if @usuario.update(register_params)
          redirect_to root_path, notice: "El usuario fue actualizado"
        end
    end
    
    def create
        @usuario = Usuario.new(register_params)
    
        if @usuario.save
            redirect_to root_path, notice: "Cuenta creada satisfactoriamente"
        else
            render 'new'
        end
    end

    private

        def register_params
            params.require(:usuario).permit(:fullname, :dni, :birthdate, :license, :license_expiration_date, :email, :password, :password_confirmation);
        end

end
