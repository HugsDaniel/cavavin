class PagesController < ApplicationController
  def home
  end

  def search
  end

  def scrap
    keyword = params['keyword']
    scrap_figaro(keyword)
    redirect_to results_path
  end

  def results
    @wines = $scrapped_wines
  end

  private

  def scrap_figaro(keyword)
    keyword.gsub!(/\s/,'-')
    url = "http://avis-vin.lefigaro.fr/recherche/#{keyword}"

    require 'open-uri'
    html_file = open(url).read
    html_doc = Nokogiri::HTML(html_file)

    $scrapped_wines = []

    html_doc.search('.wine-infos.fleft h3 a').each do |element|
      $scrapped_wines << element.text
    end
  end
end
