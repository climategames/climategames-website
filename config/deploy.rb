# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'ClimateGames'
set :repo_url, 'https://github.com/climategames/climategames.git'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp
set :branch, ENV['BRANCH'] || "master"

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, '/var/www/vhosts/acc/'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
set :pty, true

# Default value for :linked_files is []
set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml', 'config/initializers/localeapp.rb', 'config/initializers/trello.rb')

# Default value for linked_dirs is []
set :linked_dirs, fetch(:linked_dirs, []).push('public/system')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

set :passenger_restart_command, 'rvmsudo_secure_path=1 rvmsudo passenger-config restart-app'

namespace :deploy do
  desc 'Runs rake db:seed'
  task :db_seed => [:set_rails_env] do
    on primary fetch(:migration_role) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, "db:seed"
        end
      end
    end
  end
  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end
  after "deploy:migrate", "deploy:db_seed"
end
