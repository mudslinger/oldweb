Chef::Log.info("Running deploy/before_migrate.rb")
env = node[:deploy][:oldweb][:rails_env]
current_release = release_path
execute "rake assets:precompile" do
  cwd current_release
  command "bundle exec rake assets:precompile"
  environment "RAILS_ENV" => env
end

#environment "SES_KEY" => node[:deploy][:oldweb][:ses_key]
#environment "SES_SECRET" => node[:deploy][:oldweb][:ses_secret]
