# Responsible for scraping and parsing info, then "sending" to Zodiac Sign class
require 'pry'

class DailyHoroscope::Scraper 
    BASE_URL = "https://www.horoscope.com"

    def scrape_index
        # Returns array with hash elements from home pg
        # Hash keys are name, birthdates, profile link+

        doc = Nokogiri::HTML(open("#{BASE_URL}/us/index.aspx"))
        index = doc.css("div.grid.grid-6 a")
        
        index.map do |sign|
            {
                :name => sign.css("h3").text.strip,
                :birthdates => sign.css("p").text.strip,
                :profile_url => sign['href']
            }
        end
    end       
    
    def import
        scrape_index.each {|sign_attributes| DailyHoroscope::ZodiacSign.create_from_index(sign_attributes)}
    end

    def scrape_profile(profile_url) 
        # **RETURNS CONTAINER FOR INFORMATION

        # Returns another array with hash elements
        # Hash keys are current day's horoscope reading, as well as career & health link

        doc = Nokogiri::HTML(open("#{BASE_URL}#{profile_url}"))
        profile = doc.css("div.main-horoscope")      
        profile_info = {}  

        profile.map do |info|
            profile_info = {       
                current: info.css("p").text.split(/\s-\s/)[1],
                career_url: info.css("div.more-horoscopes a")[2]['href'],
                health_url: info.css("div.more-horoscopes a")[4]['href']
            }
        end
        profile_info[:title] = doc.css("div.flex-start h1").text 
        profile_info
    end

    # def get_career_text(career_url)
      # Returns current day's career horoscope for specific sign
      # doc = Nokogiri::HTML(open("#{BASE_URL}#{career_url}"))
      # doc.css("div.flex-start h1").text.split[1]   => title
      # doc.css("div.main-horoscope p").text.split(/\s-\s/)[1]  => description
    # end

    # def get_health_text(health_url)
    #     # Returns current day's health horoscope for specific sign
    #     doc = Nokogiri::HTML(open("#{BASE_URL}#{health_url}"))
    #     doc.css("div.flex-start h1").text.split[1]   => title
    #     doc.css("div.main-horoscope p").text.split(/\s-\s/)[1]   => description
    # end
end