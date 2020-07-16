require 'nokogiri'
require 'open-uri'
require 'pry'


#get names and lastnames
def get_deputee_name(page)
  page = Nokogiri::HTML(open('https://www.voxpublic.org/spip.php?page=annuaire&cat=deputes&pagnum=600&lang=fr'))
  return name = page.css('h2.titre_normal')
end

def get_deputee_email(name)
  whole_title = []
  first_name = []
  surname = []
  email_list = []
  name.each do |el|
     whole_title << el.text.downcase.tr(
"ÀÁÂÃÄÅàáâãäåĀāĂăĄąÇçĆćĈĉĊċČčÐðĎďĐđÈÉÊËèéêëĒēĔĕĖėĘęĚěĜĝĞğĠġĢģĤĥĦħÌÍÎÏìíîïĨĩĪīĬĭĮįİıĴĵĶķĸĹĺĻļĽľĿŀŁłÑñŃńŅņŇňŉŊŋÒÓÔÕÖØòóôõöøŌōŎŏŐőŔŕŖŗŘřŚśŜŝŞşŠšſŢţŤťŦŧÙÚÛÜùúûüŨũŪūŬŭŮůŰűŲųŴŵÝýÿŶŷŸŹźŻżŽž",
"AAAAAAaaaaaaAaAaAaCcCcCcCcCcDdDdDdEEEEeeeeEeEeEeEeEeGgGgGgGgHhHhIIIIiiiiIiIiIiIiIiJjKkkLlLlLlLlLlNnNnNnNnnNnOOOOOOooooooOoOoOoRrRrRrSsSsSsSssTtTtTtUUUUuuuuUuUuUuUuUuUuWwYyyYyYZzZzZz")
     #tr('éèêë', 'e').tr('ô', 'o').tr("'", '')
  end
   whole_title.each do |i|
     name_split = i.split    #ya aussi .tr que j'aime bien
     first_name = name_split[1]
     surname = "#{name_split[2]}#{name_split[3]}#{name_split[4]}"
     email = "#{first_name}.#{surname}@assemblee-nationale.fr"
     email_list << email
   end
   return email_list
end

def get_first_name (name)
  first_name_array = []
  name.each do |i|
    name = i.text.split
    first_name_array << name[1]
  end
  return first_name_array
end

def get_surname (name)
  surname_array = []
  name.each do |i|
    name = i.text.split
    surname = "#{name[2]}#{name[3]}#{name[4]}"
    surname_array << surname
  end
  return surname_array
end

#get email adress

def perform
  page = Nokogiri::HTML(open("https://www.voxpublic.org/spip.php?page=annuaire&cat=deputes&pagnum=600&lang=fr"))
  name_array =  get_deputee_name(page)
  email = get_deputee_email(name_array)
  first_name = get_first_name(name_array)
  surname = get_surname(name_array)
  result = []
  x = 0
  name_array.each do
    mini_hash = Hash.new
    mini_hash['first_name'] = first_name[x]
    mini_hash['last_name'] = surname[x]
    mini_hash['email'] = email[x]
    result << mini_hash
    x+=1
  end
  return result
end

puts perform
