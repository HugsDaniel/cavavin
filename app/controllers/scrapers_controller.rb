class ScrapersController < ApplicationController
  # Search method (similar to index in rails) gets a list of wine results from the user query (in pages#home)
  def search
    search_link[:link].gsub!(/\s/,'-')
    # Creation of a new Scraper object with user query as a parameter
    @scraper = Scraper.new(search_link)

    # Construction of the figaro url
    url = "http://avis-vin.lefigaro.fr/recherche/" + @scraper.link

    # Call of results page scraping class method
    @wines = Scraper.get_wine_list(url) # => array of hashes containing all found wines' basic infos
    @wines.each do |wine|
      wine[:years] = Scraper.get_wine_years("http://avis-vin.lefigaro.fr" + wine[:link])
    end
    return @wines
  end

  # View method gets one wine's url from search method and displays the wine's years
  def show_wine
    # # Creation of a new Scraper object with wine's url as a parameter
    # @scraper = Scraper.new
    # @scraper.link = params[:link]
    #
    # # Contruction of the figaro url
    # url = "http://avis-vin.lefigaro.fr" + @scraper.link
    #
    # # Call of wine's years scraping class method
    # @years = Scraper.get_wine_years(url) # => array of hashes containing wine's years
  end

  # Show method gets year's url from view method and displays year's general informations
  def year
    # Creation of a new Scraper object with year's url as a parameter
    @scraper = Scraper.new
    @scraper.link = params[:link]

    # Construction of the figaro url
    url = "http://avis-vin.lefigaro.fr" + @scraper.link

    # Call of year's general informations scraping class method
    @wine = Scraper.get_year_info(url) # => hash containing year's general informations
  end

  # Save method creates a new wine in the cave with previous general informations
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

  def search_link
    params.require(:scraper).permit(:link)
  end
end
