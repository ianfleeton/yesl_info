require "bundler/capistrano" 

require "rvm/capistrano"
set :rvm_type, :system
set :rvm_path, "/usr/local/rvm"

set :application, "yesl_info"
set :repository,  ENV['YESL_INFO_REPOSITORY']
set :use_sudo, false

set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

set :deploy_to, "/home/admin/sites/#{application}"

server 'io.yesl.co.uk', :app, :web, :db, primary: true
set :user, 'admin'
default_run_options[:pty] = true

set :keep_releases, 5
# if you want to clean up old releases on each deploy uncomment this:
after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end

  desc "Symlinks files with secret information"
  task :symlink_secrets, :roles => :app do
    run "ln -nfs #{deploy_to}/shared/config/initializers/secret_token.rb #{release_path}/config/initializers/secret_token.rb"
    run "ln -nfs #{deploy_to}/shared/config/database.yml #{release_path}/config/database.yml"
    run "ln -nfs #{deploy_to}/shared/config/secrets.yml #{release_path}/config/secrets.yml"
  end
end

before 'deploy:assets:precompile', 'deploy:symlink_secrets'

after 'deploy:update_code', 'deploy:migrate'

ssh_options[:forward_agent] = true
