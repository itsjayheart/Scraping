require 'nokogiri'
require 'open-uri'

page = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html"))


def create_town_url_array (page)
  town_url_array = []
  website = "https://annuaire-des-mairies.com/95/"
  page.xpath('//td//a[contains(@href, 95)]').each do |el|
    el = el.to_s
    start_slice = el.index("95/") + 3
    stop_slice = el.index("\">") - 1
    el = el[start_slice..stop_slice]
    town_url_array << website + el
  end
  puts town_url_array
  return town_url_array
end

def create_town_email_hash (town_url_array)
  email_array = []
  puts "LOADING..."
  town_url_array.each do |page|
    page2 = Nokogiri::HTML(open(page))
    email = page2.css('table[1] tr[4] td[2]').text
    puts "#{email_array.length}-#{email}"
    email_array << email
  end
  town_array = []
  page = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html"))
  page.xpath('//td//a[contains(@href, 95)]').each do |el|
    puts el.text
    town_array << el.text
  end
  result = []
  x = 0
  town_array.each do |key|
    mini_hash = Hash.new
    mini_hash[key] = email_array[x]
    x = x + 1
    result << mini_hash
  end
  return result
end

puts create_town_email_hash(create_town_url_array(page))
