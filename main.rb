require 'dotenv/load'
require 'nokogiri'
require 'json'
require 'httparty'
require 'nikkou'
require 'twilio-ruby'


@subjects = []
@url1 = "https://studenthub.city.ac.uk/new-students/induction-timetables"
@url2 = "https://studenthub.city.ac.uk/new-students/induction-timetables?p=17"
@message = ""
@subj_total = ""
@and = ""

def scraper
  fetch(@url1)
  fetch(@url2)
  checker
  sms
end

private

def fetch(url)
  unparsed_page = HTTParty.get(url)
  parsed_page = Nokogiri::HTML(unparsed_page)
  @subj_total = parsed_page.css('div.induction-timetable-finder__results__count').text.slice!(0..1)
  @and = parsed_page.css('div.induction-timetable-finder h2').text_includes('Journalism').map do |subject|
    @subjects << subject.text
  end
end

def checker
  if @subjects.length > 3
    printer
  else
    puts "No change. #{@subj_total} subjects listed on the website."
  end
end

def printer
  inter = 'MA Interactive Journalism'
  invest = 'MA Investigative Journalism'
  ours = []

  @subjects.each do |subject|
    if subject == inter
      ours << subject
    elsif subject == invest
      ours << subject
    end
  end
  puts @message = "#{Time.now.utc.iso8601}. There are #{@subjects.length} journalism subjects listed. 
  #{if ours.length > 0; ours end}"
end


def sms
  from = ENV['TWILIO_NO']
  to = ENV['MY_NO']
  account_sid = ENV['TWILIO_SID']
  auth_token = ENV['TWILIO_TOKEN']
  client = Twilio::REST::Client.new(account_sid, auth_token)

  client.messages.create(
  from: from,
  to: to,
  body: @message
  )
end

scraper




