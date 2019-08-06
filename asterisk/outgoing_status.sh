#!/bin/bash

AUTODIALER_ROOT="/home/rails/projects/autodialer"

. ~/.bashrc

/bin/bash -l -c "cd $AUTODIALER_ROOT && pwd && RAILS_ENV=production /home/rails/.rbenv/shims/bundle exec rake outgoing:status[$1,$2] --silent >> $AUTODIALER_ROOT/log/outgoing_status.log 2>> $AUTODIALER_ROOT/log/outgoing_status_error.log"


