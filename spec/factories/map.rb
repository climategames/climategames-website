FactoryGirl.define do
  factory :map do
    sequence(:slug) { |n| "map-#{n}" }
    endpoint "http://factory-endpoint.com/api"
  end
end
