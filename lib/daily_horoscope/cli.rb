require 'pry'

class DailyHoroscope::CLI
	def call
		DailyHoroscope::Scraper.new.import
		puts "\n*** Welcome! Read Your Horoscope for #{Time.new.strftime("%A, %B %d")} ***"    
		list_signs
		main_menu
	end

   def list_signs
		puts "\n"
		DailyHoroscope::ZodiacSign.all.each.with_index(1) {|sign, i|
			puts "#{i}. #{sign.name}, #{sign.birthdates}"}
   end

   def main_menu
		puts "\n*** Main Menu Commands ***"
		puts <<-DOC.gsub /^\s+/, ""
		- Enter a number from 1-#{DailyHoroscope::ZodiacSign.all.length} to choose your zodiac sign.
		- Type 'list' to view all zodiac signs.
		- Type 'exit' to leave.
		DOC

		puts "\nPlease enter a command:"
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
		puts "\nWould you like to read more?\n\n"
		puts <<-DOC.gsub /^\s+/, ""
		- To get your love reading, type 'love'.
		- To get your career reading, type 'career'.
		- To get your health reading, type 'health'.
		- To view all readings, type 'all'.
		- To return to the main menu, type 'menu'.
		- Type 'exit' to leave.
		DOC

		puts "\nPlease enter what you'd like to do:"
		input = gets.strip.downcase

		case input 
		when "love"
			puts "#{sign.love}"
			read_more(sign)
		when "career"
			puts "#{sign.career}"
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
		puts <<-DOC.gsub /^\s+/, ""
		#{sign.love}
		#{sign.career}
		#{sign.health}
		DOC
	end

	def invalid_input
		puts "\nHmm, that's an invalid input. Please see the menu for acceptable commands."
	end
	
   def goodbye
		puts "\nCome back tomorrow for your new horoscope! Byeee! (:"
	end
end