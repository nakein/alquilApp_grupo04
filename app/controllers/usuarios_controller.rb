class UsuariosController < ApplicationController

    def update
      if (current_usuario.role=0)
        @usuario = current_usuario
        copy = @usuario.dup
        copy.license.attach(@usuario.license.blob)
        if @usuario.update(profile_params)
          redirect_to perfil_mi_perfil_path, notice: "La licencia fue actualizada"
        else
          @usuario.license.attach(copy.license.blob)
          render "perfil/mi_perfil"
        end
      else
        if(current_usuario.role=2)
          @usuario = Usuario.find(params[:id])
          render "supervisors/show"
        end
      end
    end

    def show
      @usuario = Usuario.find(params[:id])
    end

    private

        def profile_params
            params.require(:usuario).permit(:fullname, :dni, :birthdate, :license, :email);
        end
end
