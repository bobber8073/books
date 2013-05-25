require "bundler/capistrano"
require "rvm/capistrano"  
                
set :default_environment, {
  'PATH' => "/usr/local/bin:/usr/local/sbin:$PATH"
}


set :rvm_ruby_string, 'ruby-2.0.0-p195@books'
set :rvm_type, :user 

set :application, "books"
set :domain, "books.conklins.net"
set :repository,  "git@github.com:bobber8073/books.git"
set :user, "deployer"
set :use_sudo, false
set :deploy_to, "/Users/deployer/Rails_Sites/books"
set :deploy_via, :remote_cache
set :branch, "master"
set :scm, :git
ssh_options[:auth_methods] = %w(password keyboard-interactive)
set :ssh_options, {:forward_agent => true}
# ssh_options[:keys] = %w(/Users/hal/.ssh/id_rsa)              # If you are using ssh_keys
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

server "books.conklins.net", :web, :app, :db, :primary => true


set :rails_env, "production"
set :unicorn_binary, "bundle exec unicorn"
set :unicorn_config, "#{current_path}/config/unicorn.rb"
set :unicorn_pid, "#{current_path}/tmp/pids/unicorn.pid"

# hook for the symlink
# after "deploy:finalize_update", :after_update_code


# create a symlink to the application.yml file
task :after_update_code do
#  run "ln -s #{shared_path}/application.yml #{release_path}/config/application.yml"
  run "ln -s #{shared_path}/uploads #{release_path}/uploads"
end


# restarts the unicorn processes
namespace :deploy do
  
  desc "The start task is used by :cold_deploy to start the application up"
  task :start, :roles => :app do
    run "sudo /bin/launchctl load /Library/LaunchDaemons/net.conklins.books.unicorn.plist"
  end

  desc "Restart the unicorn master"
  task :restart, :roles => :app do
    run "sudo /bin/launchctl unload /Library/LaunchDaemons/net.conklins.books.unicorn.plist"
    run "sudo /bin/launchctl load /Library/LaunchDaemons/net.conklins.books.unicorn.plist"
  end

  desc "Stop the unicorn master"
  task :stop, :roles => :app do
    run "sudo /bin/launchctl unload /Library/LaunchDaemons/net.conklins.books.unicorn.plist"
  end

end
