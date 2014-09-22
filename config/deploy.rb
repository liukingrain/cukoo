set :repo_url, "git@nibynic.com:cuckoo.git"

set :tmp_dir, "/home/wojcieszka/www/tmp"

role :app, %w{wojcieszka@wojcieszka.megiteam.pl}
role :web, %w{wojcieszka@wojcieszka.megiteam.pl}
role :db,  %w{wojcieszka@wojcieszka.megiteam.pl}

set :whenever_identifier, -> { "#{fetch(:application)}_#{fetch(:stage)}" }

# set :format, :pretty
set :log_level, :info
# set :pty, true

set :linked_files, %w{config/database.yml}
set :linked_dirs, %w{log tmp public/uploads db/sphinx}

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

after "deploy:publishing", "deploy:restart"

before "deploy:updating", "thinking_sphinx:stop"
before "thinking_sphinx:start", "thinking_sphinx:index"
after  "deploy:restart", "thinking_sphinx:start"

# after  "deploy:restart", "deploy:static_error_pages:generate"
