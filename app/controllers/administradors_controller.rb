class AdministradorsController < ApplicationController

    def new
    end
    
    def create

        @usuario = Usuario.new(register_params)
        @usuario.role= "administrador"
        @usuario.validated = true
        @usuario.license_expiration_date = Date.new(2024,12,5)
        
        if @usuario.save
            redirect_to root_path, notice: "Administrador creado satisfactoriamente"
        else
            render 'new'
        end
    end

    def destroy
        @usuario = Usuario.find(params[:id])
        @usuario.destroy
        redirect_to root_path, notice: "El supervisor fue eliminado"
    end

    private

        def register_params
            params.require(:usuario).permit(:fullname, :dni, :birthdate, :email, :password, :password_confirmation);
        end

end
