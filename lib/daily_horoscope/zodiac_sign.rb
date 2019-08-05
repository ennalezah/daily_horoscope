# Responsible for creating zodiac signs from scraped doc and getting additional attributes

class DailyHoroscope::ZodiacSign
   attr_accessor :name, :birthdates, :profile_url, :general, :love, :career, :money, :health
   @@all = []

   def self.all 
      @@all
   end

   def save
      self.class.all << self
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

   def general
      title = profile_doc.css("div.flex-start h1").text.cyan
      description = profile_doc.css("div.main-horoscope p").first.text.split(/\d\s-\s/)[1]
      @general ||= "\n\u{1F52E}  #{title} \n#{description}"
   end

   def love
      url = profile_doc.css("div.main-horoscope div.more-horoscopes a")[1]['href']
      @love ||= "\n\u{1F496}  #{get_horoscope(url)}"
   end

   def career
      url = profile_doc.css("div.main-horoscope div.more-horoscopes a")[2]['href']
      @career ||= "\n\u{1F4BC}  #{get_horoscope(url)}"
   end

   def money 
      url = profile_doc.css("div.main-horoscope div.more-horoscopes a")[3]['href']
      @money ||=  "\n\u{1F4B5}  #{get_horoscope(url)}"
   end

   def health
      url = profile_doc.css("div.main-horoscope div.more-horoscopes a")[4]['href']
      @health ||= "\n\u{1F33F}  #{get_horoscope(url)}" 
   end

   def profile_doc
      Nokogiri::HTML(open("#{BASE_URL}#{self.profile_url}"))
   end

   def get_horoscope(url)
      doc = Nokogiri::HTML(open("#{BASE_URL}#{url}"))
      title = doc.css("div.flex-start h1").text.split[0..1].join(' ').cyan
      description = doc.css("div.main-horoscope p").first.text.split(/\d\s-\s/)[1]
      "#{title} \n#{description}"
   end

   def all_horoscopes
      [self.general, self.love, self.career, self.money, self.health]
   end
end