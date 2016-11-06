namespace :db do
  task :migrate_databases do
    Rake::Task['db:migrate_test_database'].invoke
    Rake::Task['db:migrate_development_database'].invoke
    
  end
  
  task :migrate_test_database do
    ENV['RACK_ENV'] = 'test'
    ActiveRecord::Base.establish_connection(:test)
    begin
      Rake::Task['db:migrate'].invoke
      sleep 5
    rescue
    end
    ActiveRecord::Base.connection.close
  end
  
  task :migrate_development_database do
    ENV['RACK_ENV'] = 'development'
    ActiveRecord::Base.establish_connection(:development)
    begin
      Rake::Task['db:migrate'].invoke
      sleep 5
    rescue
    end
    ActiveRecord::Base.connection.close
  end
end