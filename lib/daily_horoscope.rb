module DailyHoroscope
end

require_relative '../config/environment'

BASE_URL = "https://www.horoscope.com"

class String
	def red; "\e[31m#{self}\e[0m" end
	def green; "\e[32m#{self}\e[0m" end
	def magenta; "\e[35m#{self}\e[0m" end
	def cyan; "\e[36m#{self}\e[0m" end
  
	def bold; "\e[1m#{self}\e[22m" end
	def italic; "\e[3m#{self}\e[23m" end
	def underline; "\e[4m#{self}\e[24m" end
end