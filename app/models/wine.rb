class Wine < ApplicationRecord

  def self.wine_by_figaro(url)
    html_file = open(url)
    html_doc = Nokogiri::HTML(html_file)

    @wine = extract_wine_infos(html_doc.search('#millesime'))
    new_wine = Wine.new(@wine)

    if new_wine.valid?
      new_wine.save!(@wine)
    else
      puts "Erreur"
    end
  end
end

def extract_wine_infos(html_page)
  wine_info = {}
  html_page.each do |element|
    # wine_info[:wine] = "https:" + element.attribute('href').value
    wine_info[:domain] = element.search('#millesime-region > li:first > a').text
    wine_info[:wine] = element.search('#millesime-region > li')[1].search('a').text
    wine_info[:region] = element.search('#millesime-region > li')[2].search('a').text
    wine_info[:appelation] = element.search('#millesime-region > li')[3].search('a').text
    wine_info[:grape] = [element.search('#millesime-region > li')[4].search('a')[0].text, element.search('#millesime-region > li')[4].search('a')[1].text]
    wine_info[:color] = element.search('.millesime-type').text.strip
    wine_info[:figaro_note] = element.search('.note-expert').text

    wine_info
  end
  return wine_info
end
