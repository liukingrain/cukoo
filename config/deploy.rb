lock '3.2.1'

set :application, 'cuckoo'
set :repo_url, 'git@bitbucket.org:wojcieszka/cuckoo.git'
set :branch, 'master'
set :user, 'wojcieszka'

set :deploy_to, '/home/wojcieszka/www/cuckoo'

# FIXME: .ruby-{version,gemset} files should be in repository
set :linked_files, %w{config/database.yml .ruby-version .ruby-gemset}
set :linked_dirs, %w{public/uploads tmp/pids tmp/cache log}

# TODO: Check, why rvm1/capistrano3 can't detect rvm path on his own
set :rvm1_ruby_version, "2.0.0"
fetch(:default_env).merge!( rvm_path: "/home/wojcieszka/www/.rvm" )

set :tmp_dir, '/home/wojcieszka/www/tmp/cuckoo'
namespace :deploy do
  desc "Restart application"
  task :restart do
    on roles(:app) do
      execute "appctl restart wojcieszka"
    end
  end

  # TODO: I've created symlink to home/wojcieszka/www/wojcieszka from
  #       home/wojcieszka/www/cuckoo/current manually, automate this
  # task :symlink_shared do
  #   run "ln -nfs #{shared_path}/.environment #{release_path}/.environment"
  # end

end

before "deploy:updating", "thinking_sphinx:stop"
before "thinking_sphinx:start", "thinking_sphinx:index"
after  "deploy:restart", "thinking_sphinx:start"

after  "deploy:restart", "deploy:static_error_pages:generate"
