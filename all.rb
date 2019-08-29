require 'nokogiri'
require 'json'
require 'httparty'
require 'nikkou'


@subjects = []
@url1 = "https://studenthub.city.ac.uk/new-students/induction-timetables"
@url2 = "https://studenthub.city.ac.uk/new-students/induction-timetables?p=17"
@url3 = "https://studenthub.city.ac.uk/new-students/induction-timetables?p=33"
@url4 = "https://studenthub.city.ac.uk/new-students/induction-timetables?p=49"
@url5 = "https://studenthub.city.ac.uk/new-students/induction-timetables?p=65"
@message = ""
@subj_total = ""

def main
  parser(@url1)
  parser(@url2)
  parser(@url3)
  parser(@url4)
  parser(@url5)
  printer
end

def parser(url)
  unparsed_page = HTTParty.get(url)
  parsed_page = Nokogiri::HTML(unparsed_page)
  parsed_page.css('div.induction-timetable-finder h2').map do |subject|
    @subjects << subject.text
  end
end

def printer
  courses = "There are #{@subjects.length} subjects listed"

  puts ""
  puts "Time: #{Time.now.utc.iso8601}"
  puts "-----------------------------"
  @subjects.each do |subject|
    puts subject
  end
  puts "-----------------------------"
  puts courses
end

main

