require 'machinist/active_record'
require 'sham'
require 'faker'

Sham.define do
  brief  { Faker::Lorem.paragraphs(1) }
  discipline(:unique => false) {'automation'}
  category(:unique => false) {'concept'}
end

LearningObjective.blueprint do
  brief
  discipline
  category
end