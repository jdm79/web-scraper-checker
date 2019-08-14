# web-scraper-checker

web scraper program using Ruby, to check when my MA course is finally listed on their website so I can see when everything happens etc.

## stack

*'html' gem to scrape the html from the web
*'nokogiri' gem to parse the html into whatever I want to parse it into
*'nikkou' gem to perform regex check for key words in the parsed html
*'whenever' gem to create a chron job which automatically pings the website every hour to see if anything has changed
