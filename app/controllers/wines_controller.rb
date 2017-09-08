class WinesController < ApplicationController
  before_action :set_wine, only: [:show]

  def index
    @wines = Wine.all
  end

  def show
  end

  def new
    @wine = Wine.new
  end

  def create
    @wine = Wine.create(wine_params)

    if @wine.save
      redirect_to wine_path(@wine)
      flash[:notice] = "Vous avez ajouté un vin à votre cave !"
    else
      flash[:alert] = "La manip n'a pas fonctionné, réessayez."
    end
  end

  private

  def set_wine
    @wine = Wine.find(params[:id])
  end

  def wine_params
    params.require(:wine).permit(:appelation, :domain, :year, :color)
  end

end
