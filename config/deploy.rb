set :application, "ThaiCrave"
set :repository,  "git@github.com:elemyntic/thaicrave-rails.git"

set :scm, "git"
set :ssh_options, { :forward_agent => true }
set :branch, "master"
set :deploy_via, :remote_cache

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
   task :start do ; end
   task :stop do ; end
   task :restart, :roles => :app, :except => { :no_release => true } do
     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
   end
end
