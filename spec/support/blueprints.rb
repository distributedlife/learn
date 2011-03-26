require 'machinist/active_record'
require 'sham'
require 'faker'

Sham.define do
  brief  { Faker::Lorem.paragraphs(1) }
  discipline(:unique => false) {'automation'}
  category(:unique => false) {'concept'}
  pending(:unique => false) {false}
end

LearningObjective.blueprint do
  brief
  discipline
  category
  pending
end