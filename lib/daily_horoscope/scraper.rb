class DailyHoroscope::Scraper 
    BASE_URL = "https://www.horoscope.com/us/index.aspx"

    def self.scrape_index
        #returns container of zodiac information from index page
        index = Nokogiri::HTML(open(BASE_URL))
        index.css("section.choose-zodiac div.grid.grid-6")

        # :name => sign.css("h3").text.strip,
        # :birthdates => sign.css("p").text.strip
        # :profile_url => sign.css("a").first["href"]
    end

    def self.scrape_profile(profile_url)
        #returns container of horoscope and career/health urls from profile page
        profile = Nokogiri::HTML(open(profile_url)
        profile.css("div.main-horoscope")    

        # horoscope: profile.css("p").text
        # career url: profile.css("div.more-horoscopes a")[2]['href']
        # health url: profile.css("div.more-horoscopes a")[4]['href']
    end

    def parse_career_horoscope
        career_url = self.scrape_profile.css("div.more-horoscopes a")[2]['href']
        career = Nokogiri::HTML(open(career_url))
        c = career.css("div.main-horoscope")

        c.map do |description|
            description.css("p").first.text
        end
    end

    def parse_health_horoscope
        health_url = self.scrape_profile.cssprofile.css("div.more-horoscopes a")[4]['href']
        health = Nokogiri::HTML(open(health_url))
        h = health.css("div.main-horoscope")

        h.map do |description|
            description.css("p").first.text
        end
    end

    def create_zodiac_signs
        scrape_index.each {|sign| DailyHoroscope::ZodiacSign.create_from_index(sign)}
    end
end