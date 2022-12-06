class MainController < ApplicationController
  #before_action :authenticate_usuario!

  def home
    @usuarios = Usuario.all
    @tarifa = Rate.find(1)
    @vehiculos = Vehiculo.near([-34.9072, -57.9506], 0.5, units: :km)
    if(@vehiculos.size >= 1)
      if params[:value] == "less"
        @vehiculos = @vehiculos.order(params[:sort])
      elsif params[:value] == "more"
        @vehiculos = @vehiculos.order("#{params[:sort]} DESC")
      else
        puts "Sin cambios"
      end
    else
      @vehiculos = Vehiculo.all
    end
  end

  def show
    @vehiculo = Vehiculo.find(params[:id])
  end

end
