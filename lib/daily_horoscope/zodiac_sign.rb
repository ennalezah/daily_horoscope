   # Responsible for creating signs and getting/setting their attributes from scraped data
require 'pry'
class DailyHoroscope::ZodiacSign
   attr_accessor :name, :birthdates, :profile_url
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

   def self.create_from_index(sign_attributes)
      self.new(sign_attributes)
   end

   def self.find_by_profile_url(profile_url)
      sign = self.all.find {|sign| sign.profile_url == profile_url}
   end

   def self.find_by_input(input)
      self.all[input.to_i - 1] 
   end

   def profile_doc
      Nokogiri::HTML(open("#{BASE_URL}#{self.profile_url}"))
  end

  def general
      # title = profile_doc.css("div.flex-start h1").text 
      profile_doc.css("div.main-horoscope p").first.text.split(/\s-\s/)[1]   \
      # puts <<-DOC
      # #{title}
      # #{description}
      # DOC
  end

  def career
      url = profile_doc.css("div.main-horoscope div.more-horoscopes a")[2]['href']
      doc = Nokogiri::HTML(open("#{BASE_URL}#{url}"))
      doc.css("div.main-horoscope p").first.text.split(/\s-\s/)[1]
  end

  def health
      url = profile_doc.css("div.main-horoscope div.more-horoscopes a")[4]['href']
      doc = Nokogiri::HTML(open("#{BASE_URL}#{url}"))
      doc.css("div.main-horoscope p").first.text.split(/\s-\s/)[1]
  end



   # def career_horoscope(career_url)
      # career_horoscope = DailyHoroscope::Scraper.get_career_text(career_url)  
      # @career_horoscope = career_horoscope      
   # end

   # def health_horoscope(health_url)
      # horoscope = DailyHoroscope::Scraper.get_health_text(career_url)
      # @health_horoscope = health_horoscope
   # end
end