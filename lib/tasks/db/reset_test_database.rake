namespace :db do
  task :reset_test_database do
    ENV['RACK_ENV'] = 'test'
    ActiveRecord::Base.establish_connection(:test)

    # Clean Database
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.clean

    # Reseed
    Rake::Task['db:seed'].invoke
  end
end