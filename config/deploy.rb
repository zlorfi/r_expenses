# config valid only for current version of Capistrano
lock '3.11.2'

set :application, 'r_expenses'
set :repo_url, 'git@github.com:zlorfi/r_expenses.git'

# Default branch is :master
ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default value for :linked_files is []
set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')

# Default value for linked_dirs is []
set :linked_dirs, fetch(:linked_dirs, []).push(
  'log',
  'tmp/pids',
  'tmp/cache',
  'tmp/sockets',
  'public/system',
  'public/packs',
  'node_modules'
)

# restart the old way
set :passenger_restart_with_touch, true

before 'deploy:assets:precompile', 'deploy:yarn_install'
before 'passenger:restart', 'deploy:clean_up_old_cache'

namespace :deploy do
  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

  desc 'Run rake yarn install'
  task :yarn_install do
    on roles(:web) do
      within release_path do
        execute("cd #{release_path} && yarn install --silent --no-progress --no-audit --no-optional")
      end
    end
  end

  desc 'Delelte old bootsnap caches'
  task :clean_up_old_cache do
    on roles(:web) do
      within release_path do
        execute(:rake, 'tmp:cache:clear')
      end
    end
  end
end