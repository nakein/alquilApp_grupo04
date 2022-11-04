class MainController < ApplicationController
  #before_action :authenticate_usuario!

  def home
    @vehiculos = Vehiculo.all
  end

  def show
    @vehiculo = Vehiculo.find(params[:id])
  end

end
