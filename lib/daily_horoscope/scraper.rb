# Responsible for scraping zodiac signs and sending info to ZodiacSign

require 'pry'

class DailyHoroscope::Scraper

    def scrape_index
        index_doc = Nokogiri::HTML(open("#{BASE_URL}/us/index.aspx"))
        index = index_doc.css("div.grid.grid-6 a")

        index.each do |info|
            sign = DailyHoroscope::ZodiacSign.new

            sign.name = info.css("h3").text.strip
            sign.birthdates = info.css("p").text.strip
            sign.profile_url = info['href']            
            sign.save            
        end
    end      
end