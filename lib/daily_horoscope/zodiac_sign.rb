class ZodiacSign
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

    def additional_attributes
        add_attributes.each {|key, value| self.send("#{key}=", value)}
    end

end