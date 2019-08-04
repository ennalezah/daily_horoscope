require 'pry'
require 'nokogiri'
require 'open-uri'
require 'colorize'

require_relative '../lib/daily_horoscope/scraper'
require_relative '../lib/daily_horoscope/zodiac_sign'
require_relative '../lib/daily_horoscope/cli'
require_relative '../lib/daily_horoscope/version'

BASE_URL = "https://www.horoscope.com"