require 'nokogiri'
require 'open-uri'

page = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))

a_currencies = page.xpath('//td//a[contains(@href,currencies)]')

def create_hash (array, start, stop)
  value_array = []
  key_array = []
  result = Hash.new
  array.each do |string|
    string = scan_string(string.to_s, start, stop)
    if string.include?(?$)
      value_array.concat([string])
    else
      key_array.concat([string])
    end
  end
  value_array.reject!.with_index{|_, i| i.odd?}
  x = 0
  key_array.each do |key|
    result[key] = value_array[x]
    x = x + 1
  end
  return result
end

def scan_string (string, start, stop)
  start_slice = string.index(start[0],start[1]) + 1
  stop_slice = string.index(stop[0],stop[1]) - 1
  return string[start_slice..stop_slice]
end


puts crypto_value = create_hash(a_currencies,[">", 1],["<", 1])
puts crypto_value.length

