# Creates webpage's doc and scrapes required info from it

class DailyHoroscope::Scraper
    def initialize(url = nil)
        @url = url
    end

    def self.scrape_index
        index_doc = Nokogiri::HTML(open("#{BASE_URL}/us/index.aspx"))
        index_doc.css("div.grid.grid-6 a").each do |info|
            sign = DailyHoroscope::ZodiacSign.new

            sign.name = info.css("h3").text.strip
            sign.birthdates = info.css("p").text.strip
            sign.profile_url = info['href']            
            sign.save            
        end
    end
    
    def self.scrape_profile(profile_url) 
        sign = DailyHoroscope::ZodiacSign.find_by_profile_url(profile_url)
        profile_doc = Nokogiri::HTML(open("#{BASE_URL}#{sign.profile_url}"))
        
        profile_doc.css("div.main-horoscope div.more-horoscopes").map do |info|
            sign.love_url = info.css("a")[1]['href']
            sign.career_url = info.css("a")[2]['href']
            sign.money_url = info.css("a")[3]['href']
            sign.health_url = info.css("a")[4]['href']
        end
    end
end