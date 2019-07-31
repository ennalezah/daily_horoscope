class ZodiacSign
    attr_accessor :name, :birthdates, :profile_url, :horoscope, :career_horoscope, :health_horoscope
    @@all = []

    def self.all 
        @@all
    end

    def initialize(name:, birthdates:, profile_url:)
        @name = name
        @birthdates = birthdates
        @profile_url = profile_url
        self.class.all << self
    end

    def self.create_from_index(sign) 
        self.new(
            name: sign.css("h3").text.strip,
            birthdates: sign.css("p").text.strip,
            profile_url: "https://www.horoscope.com#{sign.css("a").first["href"]}"
        )
    end

    def horoscope(profile_url)
        self.horoscope = Scraper.scrape_profile(profile_url).each {|info| profile.css("p").text}
    end

    def career_horoscope(profile_url)
        Scraper.scrape_profile(profile_url)
    end
end