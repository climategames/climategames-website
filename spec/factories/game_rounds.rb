FactoryGirl.define do
  factory :game_round do
    name "Factory"
    starts_at Date.new(2000,1,1)
    ends_at Date.new(2100,1,1)
  end
end
