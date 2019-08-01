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

    def self.scrape_profile(profile_url)
        #returns container of horoscope and career/health urls from profile page
        doc = Nokogiri::HTML(open("#{BASE_URL}#{profile_url}"))
        horoscopes = doc.css("div.main-horoscope")  
        
        horoscopes.map do |info|
            {                
                horoscope: profile.css("p").text
                career_url: profile.css("div.more-horoscopes a")[2]['href']
                health_url: profile.css("div.more-horoscopes a")[4]['href']
            }
        end

        
    end

    def get_career(career_url)
        doc = Nokogiri::HTML(open("#{BASE_URL}#{career_url}"))
        career = doc.css("div.main-horoscope")

        c.map do |description|
            description.css("p").first.text.split(/\s-\s/)[1]
        end
    end

    def get_health(health_url)
        doc = Nokogiri::HTML("#{BASE_URL}#{health_url}"))
        health = doc.css("div.main-horoscope")

        h.map do |description|
            description.css("p").first.text.split(/\s-\s/)[1]
        end
    end
end