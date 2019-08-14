require 'nokogiri'
require 'json'
require 'httparty'
require 'nikkou'

def Scraper

  subjects = []

  url = "https://studenthub.city.ac.uk/new-students/induction-timetables"
  unparsed_page = HTTParty.get(url)
  parsed_page = Nokogiri::HTML(unparsed_page)

  parsed_page.css('div.induction-timetable-finder h2').text_includes('Journalism').map do |subject|
    subjects << subject.text
  end

  url2 = "https://studenthub.city.ac.uk/new-students/induction-timetables?p=17"
  unparsed_page2 = HTTParty.get(url2)
  parsed_page2 = Nokogiri::HTML(unparsed_page2)

  # parsed_page2.search('div.induction-timetable-finder h2').xpath('text()').map do |subj|
  #   subjects << subj
  # end


  parsed_page2.css('div.induction-timetable-finder h2').text_includes('Journalism').map do |subject|
    subjects << subject.text
  end

  subjects.each do |subject|
      puts subject
  end

  # h2class = "induction-timetable-finder-result__title"
end

Scraper()


