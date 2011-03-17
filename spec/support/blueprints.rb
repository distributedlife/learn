require 'machinist/active_record'
require 'sham'
require 'faker'

Sham.define do
  brief  { Faker::Lorem.paragraphs(1) }
  discipline {"automation"}
end

LearningObjective.blueprint do
  brief
  discipline
end