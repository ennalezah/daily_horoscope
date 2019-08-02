# Responsible for scraping and parsing info, then "sending" to Zodiac Sign class
require 'pry'

class DailyHoroscope::Scraper 
    BASE_URL = "https://www.horoscope.com"

    def scrape_index
        # Returns array with hash elements from home pg
        # Hash keys are name, birthdates, profile link

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
    
    def import_zodiac_signs
        scrape_index.each {|sign_attr| DailyHoroscope::ZodiacSign.new(sign_attr)}
    end

    def scrape_profile(profile_url)
        # Returns another array with hash elements
        # Hash keys are current day's horoscope reading, as well as career & health link

        doc = Nokogiri::HTML(open("#{BASE_URL}#{profile_url}"))
        profile = doc.css("div.main-horoscope")        

        profile.map do |info|
            {                
                horoscope: info.css("p").text.split(/\s-\s/)[1],
                career_url: info.css("div.more-horoscopes a")[2]['href'],
                health_url: info.css("div.more-horoscopes a")[4]['href']
            }
        end
    end

    # def import_profile
    #     scrape_profile.each{|more_info| DailyHoroscope::ZodiacSign.add_attributes(more_info)}
    # end

    # def get_career_text(career_url)
    #     # Returns current day's career horoscope for specific sign
    #     doc = Nokogiri::HTML(open("#{BASE_URL}#{career_url}"))
    #     doc.css("div.main-horoscope p").text.split(/\s-\s/)[1]
    # end

    # def get_health_text(health_url)
    #     # Returns current day's health horoscope for specific sign
    #     doc = Nokogiri::HTML(open("#{BASE_URL}#{health_url}"))
    #     doc.css("div.main-horoscope p").text.split(/\s-\s/)[1]
    # end
end