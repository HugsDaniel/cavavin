class ScrapersController < ApplicationController
  def search
    url = "http://avis-vin.lefigaro.fr/recherche/cadet-bon-2016"
    @wines = Scraper.get_wine_list(url)
    puts @wines
  end

  def show
    @scraper = Scraper.new
    @scraper.link = params[:link]

    url = "http://avis-vin.lefigaro.fr" + @scraper.link + "/2016"
    @wine = Scraper.wine_by_figaro(url)
  end

  def save
    @wine = Wine.create(wine_params)

    if @wine.save
      redirect_to wine_path(@wine)
      flash[:notice] = "Vous avez ajouté un vin à votre cave !"
    else
      flash[:alert] = "La manip n'a pas fonctionné, réessayez."
    end
  end

  private

  def wine_params
    params.require(:wine).permit(:appelation, :domain, :year, :color, :stock, :region, :wine, :figaro_note, :grape)
  end
end
