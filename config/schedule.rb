# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

set :output, "log/cron_log.log"

#every :minute do
 # rake "dial:run", :output => {:error => 'log/dial_error.log', :standard => 'log/dial_cron.log'}
#end

#every :minute do
#  rake "mango:employee", :output => {:error => 'log/mango_employee_error.log', :standard => 'log/mango_employee_cron.log'}
#end

#every :minute do
#  rake "analysis:run", :output => {:error => 'log/analysis_error.log', :standard => 'log/analysis_cron.log'}
#end

#every :minute do
#  rake "cdr:update", :output => {:error => 'log/cdr_update_error.log', :standard => 'log/cdr_update_cron.log'}
#end
#
#every :minute do
#  rake "cdr:spool", :output => {:error => 'log/cdr_spool_error.log', :standard => 'log/cdr_spool_cron.log'}
#end

#every :minute do
#  rake "cdr:attempt", :output => {:error => 'log/cdr_attempt_error.log', :standard => 'log/cdr_attempt_cron.log'}
#end

#every :hour do
#  rake "dial:clear", :output => {:error => 'log/dial_clear_error.log', :standard => 'log/dial_clear_cron.log'}
#end
