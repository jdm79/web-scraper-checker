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
  checker
  # printer
end

def fetch(url)
  unparsed_page = HTTParty.get(url)
  parsed_page = Nokogiri::HTML(unparsed_page)
  parsed_page.css('div.induction-timetable-finder h2').text_includes('Journalism').map do |subject|
    @subjects << subject.text
  end
end

def checker
  if @subjects.length > 3
    printer
  else
    puts "No change"
  end
end

def printer
  inter = 'MA Interactive Journalism'
  invest = 'MA Investigative Journalism'
  bool = true
  courses = "There are #{@subjects.length} journalism subjects listed:"

  puts ""
  puts "Time: #{Time.now.utc.iso8601}"
  puts "-----------------------------"
  puts courses
  @subjects.each do |subject|
    if subject == inter
      puts "EUREKA! #{inter} is finally listed!" 
    elsif subject == invest
      puts "EUREKA! #{invest} is finally listed!" 
    end
  end
end

scraper


