class WinesController < ApplicationController
  before_action :set_wine, only: [:show, :destroy, :edit]

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

  def edit
  end

  def update
    @wine = Wine.update(wine_params)

    redirect_to wine_path(@wine)
    flash[:notice] = "Vous avez modifié ce vin !"
  end

  def destroy
    @wine.destroy
    redirect_to wines_path, :notice => "Vin supprimé"
  end


  private

  def set_wine
    @wine = Wine.find(params[:id])
  end

  def wine_params
    params.require(:wine).permit(:appelation, :domain, :year, :color, :stock)
  end

  def scrape_figaro(wine)
    wine.gsub!(/\s/,'-')
    url = "http://avis-vin.lefigaro.fr/recherche/#{wine}"

    html_file = open(url).read
    html_doc = Nokogiri::HTML(html_file)

    wines = []

    html_doc.search('.wine-infos.fleft h3 a').each do |element|
      wines << element.text
    end

    puts wines
  end

end
