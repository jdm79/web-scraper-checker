# require 'dotenv/load'
require 'nokogiri'
require 'json'
require 'json'
require 'httparty'
require 'nikkou'
require 'twilio-ruby'

@subjects = []
@city_url = "https://studenthub.city.ac.uk/new-students/induction-timetables"
@urls = [ @url1 = @city_url,
          @url2 = "#{@city_url}?p=17",
          @url3 = "#{@city_url}?p=33",
          @url4 = "#{@city_url}?p=49",
          @url5 = "#{@city_url}?p=65"
        ]
@message = ""
@subj_total = ""

def main
  @urls.each do |url|
    parser(url)
  end

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
  count = 5
  journalism_subjects = @subjects.uniq
  @message = "There are #{journalism_subjects.length} journalism subjects listed: #{journalism_subjects}"

  puts ""
  puts "Time: #{Time.now.utc.iso8601}"
  puts "-----------------------------"
  journalism_subjects.each do |subject|
    puts subject
  end
  puts "-----------------------------"
  puts "The page says there are #{@subj_total} courses listed"

  if journalism_subjects.length > count
    sms
    # updates count to prevent further sms's unless a new journalism subject is listed
    # this won't work - needs to be stored in a db. sqlite it!
    count = journalism_subjects
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




