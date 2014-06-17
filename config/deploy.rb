set :application, "cuckoo"
set :repo_url, "git@nibynic.com:cuckoo.git"

set :tmp_dir, "/home/cuckoo/www/tmp"

role :app, %w{cuckoo@cuckoo.megiteam.pl}
role :web, %w{cuckoo@cuckoo.megiteam.pl}
role :db,  %w{cuckoo@cuckoo.megiteam.pl}

set :rvm_ruby_version, "2.0.0@cuckoo"

set :whenever_identifier, -> { "#{fetch(:application)}_#{fetch(:stage)}" }

# set :format, :pretty
set :log_level, :info
# set :pty, true

set :linked_files, %w{config/database.yml config/application.yml .environment}
set :linked_dirs, %w{log tmp public/uploads db/sphinx public/sitemaps}

# set :default_env, { path: "/opt/ruby/bin:$PATH" }
set :keep_releases, 5

namespace :deploy do

  desc "Restart application"
  task :restart do
    on roles(:app) do
      execute "appctl restart #{fetch(:application)}"
    end
  end

  after :finishing, "deploy:cleanup"

  namespace :static_error_pages do
    task :generate do
      on roles(:web) do
        within release_path do
          with rails_env: fetch(:rails_env) do
            execute :rake, "generate_static_error_pages"
          end
        end
      end
    end
  end
end

before "deploy:updating", "thinking_sphinx:stop"
before "thinking_sphinx:start", "thinking_sphinx:index"
after  "deploy:restart", "thinking_sphinx:start"

after  "deploy:restart", "deploy:static_error_pages:generate"
