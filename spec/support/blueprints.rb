require 'machinist/active_record'
require 'sham'
require 'faker'

Sham.define do
  email {Faker::Internet.email(Faker::Name.first_name)}
  password(:unique => false) {'password'}
  name(:unique => true) {Faker::Lorem.words(1)}

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

User.blueprint do
  email
  password
  approved {true}
  admin {false}
end

UserAssessments.blueprint do
  user_id {1}
  learning_objective_id {1}
  awareness {'not assessed'}
  guidance {'not assessed'}
end