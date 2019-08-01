class DailyHoroscope::CLI
    def call
        DailyHoroscope::Scraper.new.import_zodiac_signs
        puts "\n*** Welcome! Read Your Horoscope for #{Time.new.strftime("%A, %B %d")} ***"
        list_signs
        menu
    end

    def list_signs
        puts "\n"
        DailyHoroscope::ZodiacSign.all.each.with_index {|sign, i| puts "#{i + 1}. #{sign.name}, #{sign.birthdates}"}
    end

    def menu
        puts "\n*** Main Menu Commands ***"
        puts <<-DOC.gsub /^\s+/, ""
            - Enter a number from 1-#{DailyHoroscope::ZodiacSign.all.length} to choose your zodiac sign.
            - Type 'list' to view all zodiac signs.
            - Type 'exit' to leave.
        DOC

        puts "\nPlease enter a command:"
        input = gets.strip

        if 1..DailyHoroscope::ZodiacSign.all.length.incude?(input.to_i)
            sign = DailyHoroscope::ZodiacSign.find(input.to_i)
            puts "#{sign.name} - #{sign.horoscope}"
        elsif input.downcase == "list"
            list_signs
            start
        elsif input.downcase == "exit"
            goodbye
            exit
        else
            puts "Hmm, that's not a valid input."
            start
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