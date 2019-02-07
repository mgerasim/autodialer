. ~/.bashrc
#whoami
#env

#/bin/bash -l -c "cd /home/rails/projects/autodialer/ && RAILS_ENV=development /home/rails/.rbenv/shims/bundle exec rake google:speech[$1-in.wav] --silent >> /tmp/google_speech_$2 2>> /tmp/google_speech_$2_error.log"

/bin/bash -l -c "cd /home/rails/apps/autodialer/current/ && RAILS_ENV=production /home/rails/.rbenv/shims/bundle exec rake google:speech[$1-in.wav] --silent >> /tmp/google_speech_$2 2>> /tmp/google_speech_$2_error.log"

#/bin/bash -l -c "cd /home/rails/apps/autodialer/current && RAILS_ENV=production /home/rails/.rbenv/shims/bundle exec rake google:speech[$1-in.wav] --silent >> /tmp/google_speech.log 2>> /tmp/google_speech_error.log"


