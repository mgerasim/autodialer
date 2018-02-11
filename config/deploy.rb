# Change these
server '193.124.93.198', roles: [:web, :app, :db], primary: true

#set :repo_url,        'git@example.com:username/appname.git'
set  :repo_url,        'file:///home/deploy/repos/avtodailer.git'

#set :scm, :none
#set :repository, "."
#set :deploy_via, :copy

#set :deploy_via, :copy
#set :use_sudo, false    
#set :scm, "git"
#set :repository, "."
#set :local_repository, "."
#set :branch, "master"


set :application,     'telecontact'
set :user,            'deploy'
set :puma_threads,    [4, 16]
set :puma_workers,    0

# Don't change these unless you know what you're doing
set :pty,             true
set :use_sudo,        false
set :stage,           :production
set :deploy_via,      :remote_cache
set :deploy_to,       "/home/#{fetch(:user)}/apps/#{fetch(:application)}"
set :puma_bind,       "unix://#{shared_path}/tmp/sockets/#{fetch(:application)}-puma.sock"
set :puma_state,      "#{shared_path}/tmp/pids/puma.state"
set :puma_pid,        "#{shared_path}/tmp/pids/puma.pid"
set :puma_access_log, "#{release_path}/log/puma.error.log"
set :puma_error_log,  "#{release_path}/log/puma.access.log"
set :ssh_options,     { forward_agent: true, user: fetch(:user), keys: %w(~/.ssh/id_rsa.pub) }
set :puma_preload_app, true
set :puma_worker_timeout, nil
set :puma_init_active_record, true  # Change to false when not using ActiveRecord

## Defaults:
# set :scm,           :git
# set :branch,        :master
# set :format,        :pretty
# set :log_level,     :debug
# set :keep_releases, 5

## Linked Files & Directories (Default None):
set :linked_files, %w{config/database.yml}
set :linked_dirs,  %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

namespace :puma do
desc 'Create Directories for Puma Pids and Socket'
task :make_dirs do
on roles(:app) do
execute "mkdir #{shared_path}/tmp/sockets -p"
execute "mkdir #{shared_path}/tmp/pids -p"
end
end

before :start, :make_dirs
end

namespace :deploy do
desc "Make sure local git is in sync with remote."
task :check_revision do
on roles(:app) do
unless `git rev-parse HEAD` == `git rev-parse origin/master`
puts "WARNING: HEAD is not the same as origin/master"
puts "Run `git push` to sync changes."
exit
end
end
end

desc 'Initial Deploy'
task :initial do
on roles(:app) do
before 'deploy:restart', 'puma:start'
invoke 'deploy'
end
end

task :cleanup do
on roles(:app) do
  execute "env"
end
end

before :starting,     :check_revision
after  :finishing,    :compile_assets
after  :finishing,    :cleanup
end
