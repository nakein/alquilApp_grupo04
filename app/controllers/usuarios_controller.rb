class UsuariosController < ApplicationController

    def update
      if (current_usuario.cliente?)
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
        if(current_usuario.administrador?)
          @usuario = Usuario.find(params[:id])
    
          if @usuario.update(supervisor_profile_params)
            redirect_to root_path, notice: "El supervisor fue actualizado"
          else
              render "supervisors/edit"
          end
        end
      end
    end

    def show
      @usuario = Usuario.find(params[:id])
    end

    def license_validated
      usuario = Usuario.find(params[:id]) 
      usuario.valid_license = !usuario.valid_license
      usuario.save
      redirect_to usuario_path(usuario)
    end

    def ban
      usuario = Usuario.find(params[:id])
      if(usuario.access_locked?) 
        usuario.unlock_access!
      else
        usuario.lock_access!
      end
      usuario.save
      redirect_to usuario_path(usuario)
    end

    private

        def profile_params
            params.require(:usuario).permit(:fullname, :dni, :birthdate, :license, :email);
        end

        def supervisor_profile_params
          params.require(:usuario).permit(:fullname, :dni, :birthdate, :email);
      end
end
