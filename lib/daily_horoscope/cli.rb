class DailyHoroscope::CLI

    def call
        # DailyHoroscope::Scraper.new.get_horoscopes
        puts "\nWelcome! Read Your Horoscope for #{Time.new.strftime("%A, %B %d")}."
        list_signs
        menu
        goodbye
    end

    def list_signs
        puts "\n"
        puts <<-DOC.gsub /^\s+/, ""
            1. Aries (Mar 21 - Apr 19)
            2. Taurus (Apr 20 - May 20)
            3. Gemini (May 21 - Jun 20)
            4. Cancer (Jun 21 - Jul 22)
            5. Leo (Jul 23 - Aug 22)
            6. Virgo (Aug 23 - Sep 22)
            7. Libra (Sep 23 - Oct 22
            8. Scorpio (Oct 23 - Nov 21)
            9. Saggitarius (Nov 22 - Dec 21)
            10. Capricorn (Dec 22 - Jan 19)
            11. Aquarius (Jan 20 - Feb 18)
            12. Pisces (Feb 19 - Mar 20)
        DOC
    end

    def menu
        puts "\n*** Main Menu Commands ***"
        puts <<-DOC.gsub /^\s+/, ""
            - Enter your zodiac sign's number to read today's horoscope.
            - Type 'list' to view all zodiac signs.
            - Type 'exit' to leave.
        DOC
        puts "\nPlease enter a command:"

        input = gets.strip.downcase

       
            while input != "exit"
                case input 
                when "1"
                    puts "\nAries"
                    read_more
                when "2"
                    puts "Taurus"
                    read_more
                when "list"
                    list_signs
                    menu
                else
                    puts "\nHmm, that's not a valid input."
                end
            end
        
    end

    def read_more
        puts "\nWould you like to read more? Type 'yes' to continue or 'no' to go back to the main menu."
        input = gets.strip.downcase

        if input == "yes"
            puts "more"
            menu
        elsif input == "no"
            menu
        else 
            puts "\nHmm, I'm not sure what you want."
            read_more
        end
    end

    def goodbye
        puts "See ya'! Come back tomorrow for your new horoscope! (:"
    end

end