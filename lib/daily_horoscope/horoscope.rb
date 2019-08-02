class DailyHoroscope::Horoscope
    attr_accessor :current, :career, :health
    attr_reader :sign
    @@all = []

    def self.all
        @all
    end

    def initialize
        self.class.all << self
    end
end