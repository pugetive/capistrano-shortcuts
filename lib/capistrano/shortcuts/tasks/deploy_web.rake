namespace :deploy do
  namespace :web do
    desc "Enable maintenance mode for apache"
    task :disable do
      on roles(:web) do
        execute("ln -s #{current_path}/public/maintenance.html #{current_path}/public/system/.")
      end
    end

    desc "Disable maintenance mode for apache"
    task :enable do
      on roles(:web) do
        execute "rm -f #{current_path}/public/system/maintenance.html"
      end
    end
  end
end