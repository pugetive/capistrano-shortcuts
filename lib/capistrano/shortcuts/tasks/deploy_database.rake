namespace :db do

  db_config = YAML::load_file('config/database.yml')
  local_rails_env = 'development'
  dump_file = "capistrano-shortcuts-dump-#{Time.now.to_i}.sql"

  task pull: [:dump_remote_db, :pull_db, :load_local_db]
  task push: [:dump_local_db, :push_db, :load_remote_db]

  task :dump_remote_db do
    on roles(:db) do
      dump_db(db_config[fetch(:rails_env)], dump_file)
    end
  end

  task :pull_db do
    on roles(:db) do
      run_locally do
        if db_config[fetch(:rails_env)]['host'].nil?
          domain = fetch(:domain)
        else
          domain = db_config[fetch(:rails_env)]['host']
        end
        command = "scp "
        if fetch(:aws_key_pair)
          command += "-i #{fetch(:aws_key_pair)} "
        end
        command += "#{fetch(:user)}@#{domain}:~/#{dump_file}.gz ."
        execute(command)
      end
      execute("rm #{dump_file}.gz")
    end
  end

  task :load_local_db do
    run_locally do
      load_db(db_config[local_rails_env], "#{dump_file}.gz")
      execute("rm #{dump_file}.gz")
    end
  end

  task :dump_local_db do
    run_locally do
      dump_db(db_config[local_rails_env], "#{dump_file}")
    end
  end

  task :push_db do

    if freeze_production and fetch(:rails_env) == 'production'
      run_locally do
        execute("rm #{dump_file}.gz")
        raise "By default, I won't push the local database to production. To override this protection add this to deploy.rb:\n" +
              "set :production_protected, false'"
      end
    end

    run_locally do
      if db_config[fetch(:rails_env)]['host'].nil?
        domain = fetch(:domain)
      else
        domain = db_config[fetch(:rails_env)]['host']
      end

      command = "scp "
      if fetch(:aws_key_pair)
        command += "-i #{fetch(:aws_key_pair)} "
      end
      command += "#{dump_file}.gz #{fetch(:user)}@#{domain}:~"
      execute(command)
      execute("rm #{dump_file}.gz")
    end
  end

  task :load_remote_db do
    if freeze_production and fetch(:rails_env) == 'production'
      raise "Sorry, I won't load the remote database to production. To override this protection:\n set :production_protected, false'
"
    end
    on roles(:db) do
      load_db(db_config[fetch(:rails_env)], "~/#{dump_file}")
      execute("rm #{dump_file}.gz")
    end
  end

  def dump_db(config, output_file)
    command = "MYSQL_PWD=#{config['password']} " +
            "mysqldump -f " +
            "-u #{config['username']} "
    if config['db_host']
      command += "-h #{config['db_host']} "
    end
    command += "#{config['database']} " +
               "-r #{output_file}"
    execute(command)
    execute("gzip -f #{output_file}")
  end

  def load_db(config, input_file)
    command = "gunzip -c #{input_file} | " +
              "MYSQL_PWD=#{config['password']} " +
              "mysql " +
              "-u #{config['username']} "
    if config['db_host']
      command += "-h #{config['db_host']} "
    end
    command += "#{config['database']}"
    execute(command)
  end


  def freeze_production
    return true if fetch(:production_protected).nil?

    fetch(:production_protected)
  end

  task dump: :dump_remote_db
  task backup: :dump

end