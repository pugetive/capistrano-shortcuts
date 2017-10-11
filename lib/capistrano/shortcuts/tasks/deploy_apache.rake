namespace :apache do
  task :install do
    on roles(:app) do
      sudo("cp #{current_path}/config/apache/* /etc/apache2/sites-available/")
      execute("cd /etc/apache2/sites-available")

      sudo("a2dissite #{fetch(:domain)}.conf")
      sudo("a2ensite #{fetch(:domain)}.conf")

      sudo("a2dissite assets.#{fetch(:domain)}.conf")
      sudo("a2ensite assets.#{fetch(:domain)}.conf")

      sudo("service apache2 reload")
    end
  end
  task :reload do
    on roles(:app) do
      sudo("service apache2 reload")
    end
  end
  task :restart do
    on roles(:app) do
      sudo("service apache2 restart")
    end
  end
end
