require_relative "../lib/mairie_christmas.rb"
require 'nokogiri'
require 'open-uri'
page = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html"))

describe "method create_town_url_array" do
	it "should contain at least url address of ableiges" do
		expect(create_town_url_array(page)).to include("https://annuaire-des-mairies.com/95/ableiges.html")
		expect(create_town_url_array(page)).to include("https://annuaire-des-mairies.com/95/cergy.html")
	end
	it "should be at least 150 currencies long" do
		expect(create_town_url_array(page).length).to be >= 150
	end
end

describe "create_town_email_hash" do
 it "should contain Ableiges" do
	 expect(create_town_email_hash(create_town_url_array (page))[0].keys).to eq(["ABLEIGES"])
 end
end
