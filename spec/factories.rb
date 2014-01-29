FactoryGirl.define do
  factory :personal_engagement_list do
  end
  
  factory :question do
    body      'some question'
    priority  1
    score     8
  end

  factory :user do
    enterprise_id 'leonel.messi'
  end

  factory :template_question do
    body 'some question'
  end

  factory :role do
    name 'Admin'
  end

  factory :request do
    owner_id  1
    message   'some message'
  end
end