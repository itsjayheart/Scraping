
require_relative "../lib/app.rb"
require 'nokogiri'
require 'open-uri'
page = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))

describe "method create_hash" do
	it "contain at least Bitcoin" do
		expect(create_hash(page.xpath('//td//a[contains(@href,currencies)]'),[">", 1],["<", 1])).to include("Bitcoin")
	end
	it "is have at least 200 length" do
		expect(create_hash(page.xpath('//td//a[contains(@href,currencies)]'),[">", 1],["<", 1])).to have_size(200)
	end
end