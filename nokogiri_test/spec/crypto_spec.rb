require_relative "../lib/crypto.rb"
require 'nokogiri'
require 'open-uri'
page = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))

describe "method create_hash" do
	it "should contain at least Bitcoin" do
		expect(create_key_array(page)).to include("Bitcoin")
	end
	it "should be at least 200 currencies long" do
		expect(create_key_array(page).length).to be >= 200
	end
end

describe "create_hash" do
 it "should contain Bitcoin and its correct value" do
 	expect((create_hash(create_key_array(page), create_value_array(page)))[0].keys).to eq(["Bitcoin"])
 end
end
