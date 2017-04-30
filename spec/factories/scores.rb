FactoryGirl.define do
  factory :score do
    user { create(:user) }
    score { 0 }
    games_played { 0 }
  end
end
