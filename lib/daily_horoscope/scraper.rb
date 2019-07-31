class Sraper 

    def get_index_page
        doc = Nokogiri::HTML(open("https://www.horoscope.com/us/index.aspx"))
        zodiac_signs = doc.css("section.choose-zodiac div.grid.grid-6")

        # sign name: zodiac_signs.css("h3").text.strip
        # sign dob: zodiac_signs.css("p").text.strip
        # sign profile link: zodiac_signs.css("a").first["href"]

        zodiac_signs.map do |sign|
            {
                :sign_name => sign.css("h3").text.strip,
                :sign_dob => sign.css("p").text.strip
                :sign_profile => sign.css("a").first["href"]
            }
        end



    end
end