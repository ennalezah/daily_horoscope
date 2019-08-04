# Responsible for scraping zodiac signs and sending info to 

require 'pry'

class DailyHoroscope::Scraper 
    def scrape_index
        # Returns array with hash elements from home pg
        # Hash keys are name, birthdates, profile link+

        doc = Nokogiri::HTML(open("#{BASE_URL}/us/index.aspx"))
        index = doc.css("div.grid.grid-6 a")
        
        index.map do |sign|
            {
                :name => sign.css("h3").text.strip,
                :birthdates => sign.css("p").text.strip,
                :profile_url => sign['href']
            }
        end
    end       
    
    def import
        scrape_index.each {|sign_attributes| DailyHoroscope::ZodiacSign.create_from_index(sign_attributes)}
    end
end