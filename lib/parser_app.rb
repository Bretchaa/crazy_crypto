require 'rubygems'
require 'nokogiri'
require 'open-uri'


page = Nokogiri::HTML(URI.open("http://en.wikipedia.org/").read)
puts page