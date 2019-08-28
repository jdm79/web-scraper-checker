# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
set :output, "~/.cron_log.log"
#
# every 1.hours do
#   command "ruby main.rb"
#   # runner "MyModel.some_method"
#   # rake "some:great:rake:task"
# end

every 30.minutes do
  command "ruby ~/Ruby/scrape.rb", mailto: 'james.malvern@gmail.com'
end

# Learn more: http://github.com/javan/whenever
