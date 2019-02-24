. ~/.bashrc
/bin/bash -l -c "cd /home/rails/apps/autodialer/current && RAILS_ENV=$3 /home/rails/.rbenv/shims/bundle exec rake lead:incoming[$1,$2] --silent >> /tmp/lead_incoming_$3.log 2>> /tmp/lead_incoming_error_$3.log"
