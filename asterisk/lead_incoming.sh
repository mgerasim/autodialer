#!/bin/bash

AUTODIALER_ROOT="/home/rails/projects/autodialer/"

if [ $3 == "production" ]; then
	AUTODIALER_ROOT="/home/rails/apps/autodialer/curren/"
fi

. ~/.bashrc

/bin/bash -l -c "cd $AUTODIALER_ROOT && pwd && RAILS_ENV=$3 /home/rails/.rbenv/shims/bundle exec rake lead:incoming[$1,$2] --silent >> /tmp/lead_incoming_$3.log 2>> /tmp/lead_incoming_error_$3.log"
