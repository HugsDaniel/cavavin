class PagesController < ApplicationController
  def home
    # New scraper to pass user query params to scrapers_controller
    @scraper = Scraper.new
  end
end
