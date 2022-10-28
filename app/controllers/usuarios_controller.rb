class UsuariosController < ApplicationController

    def update
        @usuario = current_usuario
  
        if @usuario.update(profile_params)
          redirect_to perfil_mi_perfil_path, notice: "La licencia fue actualizada"
        else
          render :edit
        end
    end

    private

        def profile_params
            params.require(:usuario).permit(:fullname, :dni, :birthdate, :license, :email);
        end
end
