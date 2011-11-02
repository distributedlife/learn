# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)
require 'rake'

LearnTesting::Application.load_tasks

namespace :prod do
  desc "Take backup"
  task :backup do
    sh "heroku pgbackups:capture --expire --app momentum-prod"
  end
end

namespace :staging do
  desc "Copy latest pord backup to staging"
  task :copyfromprod do
    sh "heroku pgbackups:restore DATABASE `heroku pgbackups:url --app momentum-prod` --app momentum-preprod --confirm momentum-preprod"
  end
end

desc "Package assets for production"
task :assets do
  sh "bundle exec jammit --base-url http://momentum.distributedlife.com"
end

desc "Setup Heroku"
task :addons do
#  sh "heroku stack:migrate bamboo-ree-1.8.7 --app momentum-prod"
#  sh "heroku stack:migrate bamboo-ree-1.8.7 --app momentum-preprod"
#  sh "heroku sharing:add ci@pushflashbang.com --app momentum-prod"
#  sh "heroku sharing:add ci@pushflashbang.com --app momentum-preprod"

#  sh "heroku addons:add newrelic:standard --app momentum-prod"
#  sh "heroku addons:add custom_domains:basic --app momentum-prod"
#  sh "heroku addons:upgrade logging:expanded --app momentum-prod"
#  sh "heroku addons:add memcache:5mb --app momentum-prod"
#  sh "heroku addons:add releases:basic --app momentum-prod"
#  sh "heroku addons:add sendgrid:starter --app momentum-prod"
#  sh "heroku addons:add pgbackups:basic --app momentum-prod"
#  `heroku addons:add cron:daily --app momentum-prod`

#  sh "heroku addons:upgrade logging:expanded --app momentum-preprod"
#  sh "heroku addons:add sendgrid:starter --app momentum-preprod"
#  sh "heroku addons:add pgbackups:basic --app momentum-preprod"
end