Chef::Log.info("Running deploy/before_migrate.rb")

# map the environment_variables node to ENV
node[:deploy].each do |application, deploy|
  deploy[:environment_variables].each do |key, value|
    Chef::Log.info("Setting ENV[#{key}] to #{value}")
    ENV[key] = value
  end if deploy[:environment_variables]
end

env = node[:deploy][:oldweb][:rails_env]
current_release = release_path
execute "rake assets:precompile" do
  cwd current_release
  command "bundle exec rake assets:precompile"
  environment "RAILS_ENV" => env
end

