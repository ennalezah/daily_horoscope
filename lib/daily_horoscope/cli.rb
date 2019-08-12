# CLI controller

class DailyHoroscope::CLI
	def call
		DailyHoroscope::Scraper.scrape_index
		puts "\n\u{2728}  Welcome! Read Your Horoscope for #{Time.new.strftime("%A, %B %d")}\u{2728}".magenta  
		list_signs
		main_menu
	end

	def display_name_birthdates(sign)
		"#{sign.name} --> #{sign.birthdates}"
	end

	def list_signs
		puts "\n"
		DailyHoroscope::ZodiacSign.all.each.with_index(1) do |sign, i|
			case sign.name.capitalize
			when "Aries"
				puts "#{i}. \u{2648}  #{display_name_birthdates(sign)}"
			when "Taurus"
				puts "#{i}. \u{2649}  #{display_name_birthdates(sign)}"
			when "Gemini"
				puts "#{i}. \u{264A}  #{display_name_birthdates(sign)}"
			when "Cancer"
				puts "#{i}. \u{264B}  #{display_name_birthdates(sign)}"
			when "Leo"
				puts "#{i}. \u{264C}  #{display_name_birthdates(sign)}"
			when "Virgo"
				puts "#{i}. \u{264D}  #{display_name_birthdates(sign)}"
			when "Libra"
				puts "#{i}. \u{264E}  #{display_name_birthdates(sign)}"
			when "Scorpio"
				puts "#{i}. \u{264F}  #{display_name_birthdates(sign)}"
			when "Sagittarius"
				puts "#{i}. \u{2650}  #{display_name_birthdates(sign)}"
			when "Capricorn"
				puts "#{i}.\u{2651}  #{display_name_birthdates(sign)}"
			when "Aquarius"
				puts "#{i}.\u{2652}  #{display_name_birthdates(sign)}"
			when "Pisces"
				puts "#{i}.\u{2653}  #{display_name_birthdates(sign)}"
			else
				puts "#{i}. #{display_name_birthdates(sign)}"
			end
		end
	end

	def main_menu
		puts "\nMain Menu Commands:".underline.green
		puts <<~DOC
		- Enter a number from 1-#{DailyHoroscope::ZodiacSign.all.length} to choose your zodiac sign.
		- Type 'list' to view all zodiac signs.
		- Type 'exit' to leave.
		DOC

		puts "\nPlease enter a command:".magenta
		input = gets.strip

		if (1..DailyHoroscope::ZodiacSign.all.length).include?(input.to_i) && input.match(/\A\d{1,3}\z/) 
			sign = DailyHoroscope::ZodiacSign.find_by_input(input)
			DailyHoroscope::Scraper.scrape_profile(sign.profile_url) 
			puts "#{sign.general(sign.profile_url)}"
			read_more(sign)
		elsif input.downcase == "list"
			list_signs
			main_menu
		elsif input.downcase == "exit"
			goodbye
		else
			invalid_input
			main_menu
		end        
	end

	def read_more(sign)
		puts "\nWould you like to read more?".underline.green
		puts <<~DOC
		- To get your love reading, type 'love'.
		- To get your career reading, type 'career'.
		- To get your money reading, type 'money'.
		- To get your health reading, type 'health'.
		- To view all zodiac sign's readings, type 'all'.
		- To return to the main menu, type 'menu'.
		- Type 'exit' to leave.
		DOC

		puts "\nPlease enter what you'd like to do:".magenta
		input = gets.strip.downcase

		case input
		when "love"
			puts "#{sign.love(sign.love_url)}"
			read_more(sign)
		when "career"
			puts "#{sign.career(sign.career_url)}"
			read_more(sign)
		when "money"
			puts "#{sign.money(sign.money_url)}"
			read_more(sign)
		when "health"
			puts "#{sign.health(sign.health_url)}"
			read_more(sign)
      when "all"
         DailyHoroscope::ZodiacSign.display_all_horoscopes(sign)
			main_menu
		when "menu"
			main_menu
		when "exit"
			goodbye
		else
			invalid_input
			read_more(sign)
		end
	end

	def invalid_input
		puts "\nHmm, I don't understand that input. See menu for acceptable commands.".bold.red
	end

	def goodbye
		puts "\n\u{1F44B}  Come back tomorrow for your new horoscope. Byeee!\u{1F44B}".magenta
	end
end