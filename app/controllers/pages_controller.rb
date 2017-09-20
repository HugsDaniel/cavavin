class PagesController < ApplicationController
  def home
    @scraper = Scraper.new
  end
end
