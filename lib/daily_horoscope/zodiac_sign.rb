   # Responsible for creating signs and getting/setting their attributes from scraped data
require 'pry'
class DailyHoroscope::ZodiacSign
   attr_accessor :name, :birthdates, :profile_url
   @@all = []

   def self.all 
      @@all
   end

   def initialize(attributes)   
      attributes.each {|key, value| self.send("#{key}=", value)}
      # @name = name
      # @birthdates = birthdates
      # @profile_url = profile_url
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
      title = profile_doc.css("div.flex-start h1").text 
      description = profile_doc.css("div.main-horoscope p").first.text.split(/\s-\s/)[1]
      "\n~~~ #{title} ~~~ \n#{description}"
  end

   def love
      url = profile_doc.css("div.main-horoscope div.more-horoscopes a")[1]['href']
      doc = Nokogiri::HTML(open("#{BASE_URL}#{url}"))

      title = doc.css("div.flex-start h1").text.split[0..1].join(' ')
      description = doc.css("div.main-horoscope p").first.text.split(/\s-\s/)[1]
      "\n~~~ #{title} ~~~ \n#{description}"
   end

  def career
      url = profile_doc.css("div.main-horoscope div.more-horoscopes a")[2]['href']
      doc = Nokogiri::HTML(open("#{BASE_URL}#{url}"))

      title = doc.css("div.flex-start h1").text.split[0..1].join(' ')
      description = doc.css("div.main-horoscope p").first.text.split(/\s-\s/)[1]
      "\n~~~ #{title} ~~~ \n#{description}"
  end

  def health
      url = profile_doc.css("div.main-horoscope div.more-horoscopes a")[4]['href']
      doc = Nokogiri::HTML(open("#{BASE_URL}#{url}"))

      title = doc.css("div.flex-start h1").text
      description = doc.css("div.main-horoscope p").first.text.split(/\s-\s/)[1]
      "\n~~~ #{title} ~~~ \n#{description}"
  end
end