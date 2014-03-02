require "bundler/capistrano"
require "capistrano_colors"
load "deploy/assets"
set :whenever_command, "bundle exec whenever"
require "whenever/capistrano"

set :application, "wdomunajlepiej"

set :stages, %w(production staging)
set :default_stage, "staging"
require "capistrano/ext/multistage"

role :app, "lunchtime.megivps.pl"
role :web, "lunchtime.megivps.pl"
role :db,  "lunchtime.megivps.pl", primary: true

set :user, "lunchtime"

set :scm, "git"
set :repository, "git@annawojcieszek.com:#{application}.git"
set :deploy_via, :remote_cache

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
    run "ln -nfs #{shared_path}/.environment #{release_path}/.environment"
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    run "ln -nfs #{shared_path}/uploads #{release_path}/public/uploads"
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
after "deploy:update", "newrelic:notice_deployment"