# -*- coding: utf-8 -*-
set :application, 'sugumogu'
set :repo_url, 'git@github.com:macrocro/sugumogu.git'

# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

# repository settings
set :deploy_to, '/var/www/project/sugumogu'
set :scm, :git
set :branch, "master"
set :rails_env, "development"

# SSH settings
set :user, "kuroda"

# set :format, :pretty
# set :log_level, :debug
# set :pty, true

# set :linked_files, %w{config/database.yml}
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# set :default_env, { path: "/opt/ruby/bin:$PATH" }
# set :keep_releases, 5

# cap deploy:setup後、プロジェクトの権限変更
namespace :setup do
  task :fix_permissions do
    sudo "chown -R #{user}.#{user} #{deploy_to}"
  end
end

namespace :deploy do
  desc 'Restart application'
  task :restart do
    invoke 'unicorn:restart'
  end
end

# # Unicorn用に起動/停止タスクを変更
# namespace :unicorn do
#   desc 'start unicorn!'
#   task :start do
#     on roles(:all) do
#       run "cd #{deploy_to}; unicorn -c config/unicorn.rb -E development -D"
#     end
#   end

#   desc 'restart unicorn!'
#   task :restart do
#     on roles(:all) do
#       if File.exist? "/tmp/unicorn.pid"
#         run "kill -s USR2 `cat /tmp/unicorn.pid`"
#       end
#     end
#   end

#   desc 'stop unicorn!'
#   task :stop do
#     on roles(:all) do
#       run "kill -s QUIT `cat /tmp/unicorn.pid`"
#     end
#   end
# end



# namespace :deploy do
#   desc 'Restart application'
#   task :restart do
#     on roles(:app), in: :sequence, wait: 5 do
#       # Your restart mechanism here, for example:
#       # execute :touch, release_path.join('tmp/restart.txt')
#     end
#   end

#   after :restart, :clear_cache do
#     on roles(:web), in: :groups, limit: 3, wait: 10 do
#       # Here we can do anything such as:
#       # within release_path do
#       #   execute :rake, 'cache:clear'
#       # end
#     end
#   end
#   after :finishing, 'deploy:cleanup'
# end
