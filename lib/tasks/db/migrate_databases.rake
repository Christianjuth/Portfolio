namespace :db do
  task :migrate_test_database do
    ENV['RACK_ENV'] = 'test'
    ActiveRecord::Base.establish_connection(:test)
    begin
      Rake::Task['db:migrate'].invoke
    rescue
    end
<<<<<<< HEAD
    ActiveRecord::Base.establish_connection(:test)  
=======
    ActiveRecord::Base.establish_connection(ENV['RAILS_ENV'])  
>>>>>>> 4bc5ba611f993367645f77c218c8428982ce1b26
  end
end