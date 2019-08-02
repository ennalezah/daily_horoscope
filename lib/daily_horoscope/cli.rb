require 'pry'

class DailyHoroscope::CLI
	def call
		DailyHoroscope::Scraper.new.import
		DailyHoroscope::ZodiacSign.all
		binding.pry
		puts "\n*** Welcome! Read Your Horoscope for #{Time.new.strftime("%A, %B %d")} ***"    
		list_signs
		menu
   end

   def list_signs
		puts "\n"
		DailyHoroscope::ZodiacSign.all.each.with_index(1) {|sign, i| puts "#{i}. #{sign.name}, #{sign.birthdates} -- #{sign.career_url}"}
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

		if (1..DailyHoroscope::ZodiacSign.all.length).include?(input.to_i)
			sign = DailyHoroscope::ZodiacSign.find(input.to_i)
			puts "\nHello #{sign.name}! #{sign.current}"
		elsif input.downcase == "list"
			list_signs
			menu
		elsif input.downcase == "exit"
		   goodbye
		else
			puts "\nHmm, that's not a valid input."
			menu
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
		puts "\nSee ya' tomorrow for your new horoscope! (:"
   end
end