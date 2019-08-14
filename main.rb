require 'nokogiri'
require 'json'
require 'httparty'

def Scraper

  subjects = []

  url = "https://studenthub.city.ac.uk/new-students/induction-timetables"
  unparsed_page = HTTParty.get(url)
  parsed_page = Nokogiri::HTML(unparsed_page)

  parsed_page.css('div.induction-timetable-finder h2').map do |subject|
    subjects << subject
  end

  subjects.each do |subject|
      puts subject
  end

  url2 = "https://studenthub.city.ac.uk/new-students/induction-timetables?p=17"
  unparsed_page2 = HTTParty.get(url2)
  parsed_page2 = Nokogiri::HTML(unparsed_page2)

  parsed_page2.css('div.induction-timetable-finder h2').map do |subject|
    subjects << subject
  end

  subjects.each do |subject|
      puts subject
  end

  puts subjects.length
  # h2class = "induction-timetable-finder-result__title"
end

Scraper()


