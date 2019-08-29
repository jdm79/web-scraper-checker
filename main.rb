# require 'dotenv/load'
require 'nokogiri'
require 'json'
require 'json'
require 'httparty'
require 'nikkou'
require 'twilio-ruby'

@subjects = []
# manually find the new pages for now, predicted url5 from previous pattern
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

private

def parser(url)
  unparsed_page = HTTParty.get(url)
  parsed_page = Nokogiri::HTML(unparsed_page)
  @subj_total = parsed_page.css('div.induction-timetable-finder__results__count').text.slice!(0..1)
  parsed_page.css('div.induction-timetable-finder h2').text_includes('Journalism').map do |subject|
    @subjects << subject.text
  end
end

def printer
  # count needs to be stored in a db as a dynamic number to prevent multiple sms alerts for same
  # new course addition to list. want to update count to new number of courses listed
  # count being manually updated right now whenever new alerts come through. 30 mins to update count
  # else it sends another sms and so on
  count = 5
  journalism_subjects = @subjects.uniq
  @message = "There are #{journalism_subjects.length} journalism subjects listed: #{journalism_subjects}"

  puts ""
  puts "Time: #{Time.now.utc.iso8601}"
  puts "-----------------------------"
  journalism_subjects.each do |subject|
    puts subject
  end

  if journalism_subjects.length > count
    sms
  end
end

# twilio sms code - add your own credentials
def sms
  account_sid = <your account sid>
  auth_token = <your auth token>
  client = Twilio::REST::Client.new(account_sid, auth_token)

  client.messages.create(
  from: <twilio number>,
  to: <your number>,
  body: @message
  )
end

main




