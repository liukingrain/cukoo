require "bundler/capistrano"
require "capistrano_colors"
load "deploy/assets"
require "thinking_sphinx/capistrano"
# set :whenever_command, "bundle exec whenever"
# require "whenever/capistrano"

set :application, "wdomunajlepiej"

set :deploy_to, "/home/wdomunajlepiej/www/application"

role :app, "wdomunajlepiej.megiteam.pl"
role :web, "wdomunajlepiej.megiteam.pl"
role :db,  "wdomunajlepiej.megiteam.pl", primary: true

set :user, "wdomunajlepiej"

set :scm, "git"
set :repository, "git@annawojcieszek.com:#{application}.git"

set :use_sudo, false

namespace :deploy do
  desc "Uruchamia aplikację"
  task :start do 
    run "appctl restart #{application}"
  end
  
  desc "Restartuje aplikację"
  task :restart do
    run "appctl restart #{application}"
  end

  desc "Zatrzymuje aplikację"
  task :stop do
  end
  
  desc "Linkuje wspoldzielone pliki: konfiguracyjne i z uploadowanymi plikami"
  task :symlink_shared do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    run "ln -nfs #{shared_path}/config/smtp.yml #{release_path}/config/smtp.yml"
    run "ln -nfs #{shared_path}/uploads #{release_path}/public/uploads"
    run "ln -nfs #{shared_path}/db/sphinx #{release_path}/db/sphinx"
  end
  
  # Żeby się assety niepotrzebnie nie precompilowały
  namespace :assets do
    task :precompile, roles: :web, except: { no_release: true } do
      from = source.next_revision(current_revision)
      if capture("cd #{latest_release} && #{source.local.log(from)} vendor/assets/ app/assets/ | wc -l").to_i > 0
        run %Q{cd #{latest_release} && #{rake} RAILS_ENV=#{rails_env} #{asset_env} assets:precompile}
      else
        logger.info "Skipping asset pre-compilation because there were no asset changes"
      end
    end
  end
  
  namespace :static_error_pages do
    task :generate, roles: :web, except: { no_release: true } do
      # from = source.next_revision(current_revision)
      # if capture("cd #{latest_release} && #{source.local.log(from)} app/views/errors/ | wc -l").to_i > 0
        run %Q{cd #{latest_release} && #{rake} RAILS_ENV=#{rails_env} generate_static_error_pages}
      # else
      #   logger.info "Skipping static error pages generations because there were no changes"
      # end
    end
  end
end

before "bundle:install", "deploy:symlink_shared"
after "deploy:assets:precompile", "deploy:static_error_pages:generate"

before "deploy:update_code", "thinking_sphinx:stop"
after  "deploy:update_code", "thinking_sphinx:start"