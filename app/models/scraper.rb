class Scraper < ApplicationRecord
  # Scraping of figaro results page
  def self.get_wine_list(url)
    wines = []

    html_file = open(url)
    html_doc = Nokogiri::HTML(html_file)
    # Call of scraping method
    return get_list(html_doc) # => array oh hashes containing each found wine's basic infos
  end

  # Scraping of one wine's years
  def self.get_wine_years(url)
    html_file = open(url)
    html_doc = Nokogiri::HTML(html_file)
    # Call of scraping method on html page
    return extract_wine_years(html_doc)
  end

  # Scraping of one year's general informations
  def self.get_year_info(url)
    html_file = open(url)
    html_doc = Nokogiri::HTML(html_file)

    @year = extract_year_infos(html_doc)
    new_year = Wine.new(@year)
  end
end


# Scraping of figaro results page
def get_list(html_page)
  wines = []
  # Creation of hash for each wine, filled with each wine's basic infos
  html_page.search('.wine-container').each do |element|
    wine_basic_info = {}
    wine_basic_info[:wine] = element.search('.wine-infos > h3 > a').text.strip
    wine_basic_info[:region] = element.search('.wine-region').text.strip
    wine_basic_info[:color] = element.search('.wine-type').text.strip
    wine_basic_info[:link] = element.search('.wine-see-sheet > a').attribute('href').value

    wines << wine_basic_info
  end

  return wines # => array of hashes containing each wine's basic infos
end

# Scraping of wine's years
def extract_wine_years(html_page)
  years = []
  # Creation of hash for each year, filled with year and url
  html_page.search('#div-all-millesimes > table > tbody > tr').each do |element|
    wine_info = {}
    wine_info[:year] = element.search('.millesime > a').text
    wine_info[:link] = element.search('.millesime > a').attribute('href').value
    years << wine_info
  end
  return years # => array of hashes containing year and url for each year
end

# Scraping of year's general informations
def extract_year_infos(html_page)
  year_info = {}
  # Fills the hash with year's general informations
  html_page.search('#millesime').each do |element|
    year_info[:wine] = element.search('h2:first').text.strip
    year_info[:domain] = element.search('#millesime-region > li:first > a').text
    year_info[:year] = element.search('#millesime-region > li')[1].search('a').text
    year_info[:region] = element.search('#millesime-region > li')[2].search('a').text
    year_info[:appelation] = element.search('#millesime-region > li')[3].search('a').text
    year_info[:grape] = []
    element.search('#millesime-region > li')[4].search('a').each do |a|
      year_info[:grape] << a.text
    end
    # [0].text, element.search('#millesime-region > li')[4].search('a')[1].text]
    year_info[:color] = element.search('.millesime-type').text.strip
    year_info[:figaro_note] = element.search('.note-expert').text
  end
  return year_info # => hash of year's nformations
end
