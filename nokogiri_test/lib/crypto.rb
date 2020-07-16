require 'nokogiri'
require 'open-uri'

page = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))


def create_key_array(page)
  key_array = []
  page.css('div#__next table tr td[2]').each do |el|
     key_array.concat([el.text])
  end
  return key_array
end

def create_value_array(page)
  value_array = []
  page.css('div#__next table tr td[5]').each do |el|
    value_array.concat([el.text])
  end
  return value_array
end

def create_hash(key_array, value_array)
  result = []
  x = 0
  key_array.each do |key|
    mini_hash = Hash.new
    mini_hash[key] = value_array[x]
    x = x + 1
    result << mini_hash
  end
  return result
end


puts bit_val = create_hash(create_key_array(page), create_value_array(page))
