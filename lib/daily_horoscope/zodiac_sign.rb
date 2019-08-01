# Responsible for creating signs and getting/setting their attributes from scraped data
class DailyHoroscope::ZodiacSign

    attr_accessor :name, :birthdates, :profile_url, :career_url, :health_url, :horoscope, :career_horoscope, :health_horoscope
    @@all = []

    def self.all 
        @@all
    end
    
    def self.create_from_index(sign_attr)
        self.new(sign_attr)
    end

    def initialize(name:, birthdates:, profile_url:)
        @name = name
        @birthdates = birthdates
        @profile_url = profile_url
        self.class.all << self
    end

    def self.add_attributes(more_attr)
        more_attr.each {|key, value| self.send("#{key}=", value)}
    end

    def career_horoscope(career_url)
        @career_horoscope = DailyHoroscope::Scraper.get_career_text(career_url)        
    end

    def health_horoscope(health_url)
        @health_horoscope = DailyHoroscope::Scraper.get_health_text(career_url)
    end

    def self.find(int)
        self.all[int-1] 
    end
end