# Responsible for creating signs and getting/setting their attributes from scraped data

require_relative '../lib/daily_horoscope'

class ZodiacSign
    attr_accessor :name, :birthdates, :profile_url, :career_url, :health_url, :horoscope, :career_horoscope, :health_horoscope
    @@all = []

    def self.all 
        @@all
    end
    
    def self.create_from_index
        Scraper.scrape_index
    end

    def initialize(name:, birthdates:, profile_url:)
        @name = name
        @birthdates = birthdates
        @profile_url = profile_url
        self.class.all << self
    end

    def add_attributes
        add_attributes.each {|key, value| self.send("#{key}=", value)}
    end
end