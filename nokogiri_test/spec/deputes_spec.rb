require_relative "../lib/deputes.rb"
require 'nokogiri'
require 'open-uri'
page = Nokogiri::HTML(open('https://www.voxpublic.org/spip.php?page=annuaire&cat=deputes&pagnum=600&lang=fr'))

describe "method perform" do
	it "'s first keys should contain first_name, last_name and email as keys of each hash" do
		expect(perform[0].keys).to eq(["first_name", "last_name", "email"])
	end
	it "'s first values should not be empty" do
		expect(perform[0].values).to be_truthy
	end
	it "should be at least 400 names long" do
		expect(perform.length).to be >= 400
	end
	it "should contain Michel Zumkeller" do
		expect(perform).to include({"first_name"=>"Michel", "last_name"=>"Zumkeller", "email"=>"michel.zumkeller@assemblee-nationale.fr"})
	end
end

#"first_name"=>"David", "last_name"=>"Habib", "email"=>"david.habib@assemblee-nationale.fr"}
