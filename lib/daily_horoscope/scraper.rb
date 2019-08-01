class DailyHoroscope::Scraper 
    BASE_URL = "https://www.horoscope.com"

    def self.scrape_index
        # returns index array, hashes as elements w/ scraped sign info

        doc = Nokogiri::HTML(open("#{BASE_URL}/us/index.aspx"))
        index = doc.css("section.choose-zodiac div.grid.grid-6")

        index.map do |sign|
            {
                :name => sign.css("h3").text.strip,
                :birthdates => sign.css("p").text.strip
                :profile_url => sign.css("a").first["href"]
            }
        end
        binding.pry
    end

    def self.make_zodiac_signs
        self.scrape_index.each {|sign_attr| ZodiacSign.create_from_index(sign_attr)}
    end

    def self.scrape_profile(profile_url)
        #returns container of horoscope and career/health urls from profile page
        doc = Nokogiri::HTML(open("#{BASE_URL}#{profile_url}"))
        profile = doc.css("div.main-horoscope")  
        
        profile.map do |info|
            {                
                horoscope: info.css("p").text
                career_url: info.css("div.more-horoscopes a")[2]['href']
                health_url: info.css("div.more-horoscopes a")[4]['href']
            }
        end
    end

    def self.get_career_text(career_url)
        doc = Nokogiri::HTML(open("#{BASE_URL}#{career_url}"))
        doc.css("div.main-horoscope p").first.text.split(/\s-\s/)[1]
    end

    def self.get_health_text(health_url)
        doc = Nokogiri::HTML("#{BASE_URL}#{health_url}"))
        doc.css("div.main-horoscope p").first.text.split(/\s-\s/)[1]
    end
end