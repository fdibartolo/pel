FactoryGirl.define do
  factory :personal_engagement_list do
  end
  
  factory :question do
    body      'some question'
    priority  1
    score     8
  end

  factory :user do
    enterprise_id "leonel.messi"
  end
end