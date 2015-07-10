namespace :fitbird do
  desc 'Build development database'
  task :dev_db => ["db:drop", "db:create", "db:migrate", "db:seed"]
end
