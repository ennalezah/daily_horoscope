# Creates zodiac sign and sets its horoscopes

class DailyHoroscope::ZodiacSign
   attr_accessor :name, :birthdates, :profile_url, :love_url, :career_url, :money_url, :health_url, 
                 :general, :love, :career, :money, :health
   @@all = []

   def self.all 
      @@all
   end

   def save
      @@all << self
   end

   def initialize
      @name = name
      @birthdates = birthdates
      @profile_url = profile_url
   end

   def self.find_by_profile_url(profile_url)
      sign = self.all.find {|sign| sign.profile_url == profile_url}
   end

   def self.find_by_input(input)
      self.all[input.to_i - 1] 
   end

   def get_horoscope(url)
      doc = Nokogiri::HTML(open("#{BASE_URL}#{url}"))
      title = doc.css("div.flex-start h1").text.split[0..1].join(' ').cyan
      description = doc.css("div.main-horoscope p").first.text.split(/\d{2,5}\s-\s/)[1]
      "#{title} \n#{description}"
   end

   def horoscopes
      [self.general(profile_url), self.love(love_url), self.career(career_url), self.money(money_url), self.health(health_url)]
   end

   def self.display_all_horoscopes(sign)
		puts sign.horoscopes
	end

   def general(profile_url)
      @general ||= "\n\u{1F52E}  #{get_horoscope(self.profile_url)}"
   end

   def love(love_url)
      @love ||= "\n\u{1F496}  #{get_horoscope(self.love_url)}"
   end

   def career(career_url)
      @career ||= "\n\u{1F4BC}  #{get_horoscope(self.career_url)}"
   end

   def money(money_url)
      @money ||=  "\n\u{1F4B5}  #{get_horoscope(self.money_url)}"
   end

   def health(health_url)
      @health ||= "\n\u{1F33F}  #{get_horoscope(self.health_url)}" 
   end
end