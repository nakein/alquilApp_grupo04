class SupervisorsController < ApplicationController
   
    def index
        @usuarios = Usuario.where(role:1)
    end
    
    def new
    end

    def show
        @usuario = Usuario.find(params[:id])
    end
    
    def edit
        @usuario = Usuario.find(params[:id])
    end
    
    def update
        @usuario = Usuario.find(params[:id])
    
        if @usuario.update(supervisor_profile_params)
          redirect_to root_path, notice: "El supervisor fue actualizado"
        else
            render :edit
        end
    end
    
    def create
        @usuario = Usuario.new(register_params)
        @usuario.role=1
        @usuario.license_expiration_date = Date.new(2024,12,5)
        
        if @usuario.save
            redirect_to root_path, notice: "Supervisor creado satisfactoriamente"
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

        def supervisor_profile_params
            params.require(:usuario).permit(:fullname, :dni, :birthdate, :email);
        end
end
