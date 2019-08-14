require 'nokogiri'
require 'json'
require 'httparty'
require 'nikkou'


@subjects = []
@url1 = "https://studenthub.city.ac.uk/new-students/induction-timetables"
@url2 = "https://studenthub.city.ac.uk/new-students/induction-timetables?p=17"

def scraper
  fetch(@url1)
  fetch(@url2)
  printer
end

def fetch(url)
  unparsed_page = HTTParty.get(url)
  parsed_page = Nokogiri::HTML(unparsed_page)
  parsed_page.css('div.induction-timetable-finder h2').text_includes('Journalism').map do |subject|
    @subjects << subject.text
  end
end

def printer
  puts ""
  puts "There are #{@subjects.length} journalism subjects listed"
  puts "------------------------------------------------------"
  @subjects.each do |subject|
      puts subject
  end
end

scraper


