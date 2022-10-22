class MainController < ApplicationController
  before_action :authenticate_cliente!
  def home
  end
end
