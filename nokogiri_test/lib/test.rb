require 'nokogiri'
require 'open-uri'


page = Nokogiri::HTML(open('https://coinmarketcap.com/all/views/all/'))
page.css('div#__next table tr td[5]').each do |el|
   puts el.text
end