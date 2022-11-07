class SupervisorsController < Devise::RegistrationsController

    def index
        @usuarios = Usuario.where(role:1)
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
          redirect_to root_path, notice: "El supervisor fue actualizado"
        end
    end
    
    def create
        @usuario = Usuario.new(register_params)
        @usuario.role=1
        
        if @usuario.save
            redirect_to root_path, notice: "Supervisor creada satisfactoriamente"
        else
            render 'new'
        end
    end

    private

        def register_params
            params.require(:usuario).permit(:fullname, :dni, :birthdate, :email, :password, :password_confirmation);
        end

end