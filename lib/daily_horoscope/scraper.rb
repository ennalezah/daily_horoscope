# Responsible for creating index doc and making new instances of zodic signs from the scraped index info.

require 'pry'

class DailyHoroscope::Scraper

    def scrape_index
        index_doc = Nokogiri::HTML(open("#{BASE_URL}/us/index.aspx"))
        index_doc.css("div.grid.grid-6 a").each do |info|
            sign = DailyHoroscope::ZodiacSign.new

            sign.name = info.css("h3").text.strip
            sign.birthdates = info.css("p").text.strip
            sign.profile_url = info['href']            
            sign.save            
        end
    end
    
    def scrape_profile
        DailyHoroscope::ZodiacSign.all.each do |sign|
            profile_doc = Nokogiri::HTML(open("#{BASE_URL}sign.profile_url"))

            profile_doc.css(div.main-horoscope div.more-horoscopes).each do |info|
                sign.love_url = info.css("a")[1]['href']
                sign.career_url = info.css("a")[2]['href']
                sign.money_url = info.css("a")[3]['href']
                sign.health_url = info.css("a")[4]['href']
            end

            # Setting general horoscope
            title = profile_doc.css("div.flex-start h1").text.cyan
            description = profile_doc.css("div.main-horoscope p").first.text.split(/\d\s-\s/)[1]
            sign.general = "\n\u{1F52E}  #{title} \n#{description}"
        end
    end
end