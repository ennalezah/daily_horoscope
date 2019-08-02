# Responsible for creating signs and getting/setting their attributes from scraped data
require 'pry'
class DailyHoroscope::ZodiacSign

    attr_accessor :name, :birthdates, :profile_url, :career_url, :health_url, :current, :career, :health, :horoscopes
    @@all = []

    def self.all 
        @@all
    end

    def initialize(name:, birthdates:, profile_url:)   
        # attributes.each {|key, value| self.send("#{key}=", value)}
        @name = name
        @birthdates = birthdates
        @profile_url = profile_url
        @horoscopes = []
        self.class.all << self
    end

    def self.create_from_index(sign_attr)
        sign = self.new(sign_attr)
        sign
    end

    def self.add_attributes(profile_url)
     zodiac = self.create_from_index(sign_attr)
     zodiac.career_url = Scraper.scrape_profile(profile_url).css("div.more-horoscopes a")[2]['href']
    end

    def self.find(int)
        self.all[int-1] 
    end

    # def career_horoscope(career_url)
    #     career_horoscope = DailyHoroscope::Scraper.get_career_text(career_url)  
    #     @career_horoscope = career_horoscope      
    # end

    # def health_horoscope(health_url)
    #     horoscope = DailyHoroscope::Scraper.get_health_text(career_url)
    #     @health_horoscope = health_horoscope
    # end
end