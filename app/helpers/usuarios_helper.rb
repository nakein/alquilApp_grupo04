module UsuariosHelper
    def license_validated(usuario)
        usuario = Usuario.find(params[:id]) 
        usuario.valid_license = !usuario.valid_license
        usuario.save
    end
end
