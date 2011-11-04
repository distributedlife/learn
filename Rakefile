# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)
require 'rake'

LearnTesting::Application.load_tasks

namespace :prod do
  desc "Take backup"
  task :backup do
    `heroku pgbackups:capture --expire --app learntesting-prod`
  end
end

namespace :staging do
  desc "Copy latest pord backup to staging"
  task :copyfromprod do
    sh "heroku pgbackups:restore DATABASE `heroku pgbackups:url --app learntesting-prod` --app learntesting-preprod --confirm learntesting-preprod"
  end
end

desc "Package assets for production"
task :assets do
  `bundle exec jammit --base-url http://learn.cromulent-testing.com`
end

desc "Setup Heroku"
task :addons do
#  `heroku stack:migrate bamboo-ree-1.8.7 --app learntesting-prod`
#  `heroku stack:migrate bamboo-ree-1.8.7 --app learntesting-preprod`
#  `heroku sharing:add ci@pushflashbang.com --app learntesting-prod`
#  `heroku sharing:add ci@pushflashbang.com --app learntesting-preprod`
#
#  `heroku addons:add newrelic:standard --app learntesting-prod`
#  `heroku addons:add custom_domains:basic --app learntesting-prod`
#  `heroku addons:upgrade logging:expanded --app learntesting-prod`
#  `heroku addons:add memcache:5mb --app learntesting-prod`
#  `heroku addons:add releases:basic --app learntesting-prod`
#  `heroku addons:add sendgrid:starter --app learntesting-prod`
#  `heroku addons:add pgbackups:basic --app learntesting-prod`
#  `heroku addons:add cron:daily --app learntesting-prod`
#
#  `heroku addons:upgrade logging:expanded --app learntesting-preprod`
#  `heroku addons:add sendgrid:starter --app learntesting-preprod`
#  `heroku addons:add pgbackups:basic --app learntesting-preprod`
end