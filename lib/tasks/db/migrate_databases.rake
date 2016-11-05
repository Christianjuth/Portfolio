namespace :db do
  task :migrate_test_database do
    ENV['RACK_ENV'] = 'test'
    ActiveRecord::Base.establish_connection(:test)
    begin
      Rake::Task['db:migrate'].invoke
    rescue
    end
    ActiveRecord::Base.establish_connection(ENV['RAILS_ENV'])  
  end
end