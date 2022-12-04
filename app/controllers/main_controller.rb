class MainController < ApplicationController
  #before_action :authenticate_usuario!

  def home
    @usuarios = Usuario.all
    @tarifa = Rate.find(1)
    if params[:value] == "less"
      @vehiculos = Vehiculo.order(params[:sort])
    elsif params[:value] == "more"
      @vehiculos = Vehiculo.order("#{params[:sort]} DESC")
    else
      @vehiculos = Vehiculo.all
    end
  end

  def show
    @vehiculo = Vehiculo.find(params[:id])
  end

end
