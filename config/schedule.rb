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

every 10.minutes, mailto: 'james.malvern@gmail.com'  do
  command "ruby ~/Ruby/main.rb"
end

#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
