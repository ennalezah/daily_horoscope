class DailyHoroscope::Horoscope
   attr_accessor :current, :career, :health
   attr_reader :zodiac_sign
   @@all = []

   def self.all
      @all
   end

   def initialize
      self.class.all << self
   end

   # def current=(current)
   # end
end