# web-scraper-checker

web scraper program using Ruby, to check when my MA course is finally listed on their website so I can see when everything happens etc. twilio code allows me to sms myself with updates.

this is mainly to get back into coding, to practise webscraping for my Interactive Journalism MA at City University, London working on data journalism.

# Stack

* 'httparty' gem to scrape the html from the web
* 'nokogiri' gem to parse the html into whatever I want to parse it into
* 'nikkou' gem to perform regex check for key words in the parsed html
* 'whenever' gem to create a chron job which automatically pings the website every hour to see if anything has changed
* 'twilio' gem which allows free sms (low usage) service

# How to use (this is more for future me than anything else)

* clone this repo
* bundle install the gems
* personalise (twilio account, website and tag to scrape, dotenv config etc)
* run the program: $ ruby main.rb 

# How to use the cron job

[Click here](https://github.com/javan/whenever)


