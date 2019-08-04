# CLI controller

class DailyHoroscope::CLI
	def call
		DailyHoroscope::Scraper.new.import
		# U+1F320
		puts "\n\u{2728}  Welcome! Read Your Horoscope for #{Time.new.strftime("%A, %B %d")}\u{2728}".magenta  
		list_signs
		main_menu
	end

   def list_signs
		puts "\n"
		DailyHoroscope::ZodiacSign.all.each.with_index(1) {|sign, i|
			puts "#{i}. #{sign.name}, #{sign.birthdates}"}
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

		if (1..DailyHoroscope::ZodiacSign.all.length).include?(input.to_i)
			sign = DailyHoroscope::ZodiacSign.find_by_input(input)
			puts "#{sign.general}"
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
		- To view all readings, type 'all'.
		- To return to the main menu, type 'menu'.
		- Type 'exit' to leave.
		DOC

		puts "\nPlease enter what you'd like to do:".magenta
		input = gets.strip.downcase

		case input 
		when "love"
			puts "#{sign.love}"
			read_more(sign)
		when "career"
			puts "#{sign.career}"
			read_more(sign)
		when "money"
			puts "#{sign.money}"
			read_more(sign)
		when "health"
			puts "#{sign.health}"
			read_more(sign)
		when "all"
			display_all_horoscopes(sign)
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

	def display_all_horoscopes(sign)
		puts <<~DOC
		#{sign.love}
		#{sign.career}
		#{sign.money}
		#{sign.health}
		DOC
	end

	def invalid_input
		# U+1F937 U+200D U+2640 U+FE0F
		puts "\nHmm, I don't understand that input.\u{1F937} \nPlease see the menu for acceptable commands.".bold.red
	end
	
   def goodbye
		puts "\nCome back tomorrow for your new horoscope. See ya'! (:".magenta
	end
end