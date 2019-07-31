class Sraper 

    def scrape_index_page
        doc = Nokogiri::HTML(open("https://www.horoscope.com/us/index.aspx"))
        zodiac_signs = doc.css("section.choose-zodiac div.grid.grid-6")

        zodiac_signs.map do |sign|
            {
                :sign_name => sign.css("h3").text.strip,
                :sign_dob => sign.css("p").text.strip
                :sign_profile => sign.css("a").first["href"]
            }
        end
    end

    def scrape_sign_page
        
    end
end