FactoryGirl.define do
  factory :game, :class => 'Game' do
    date { Date.new(2017, 1, 1) }
    player_1 { create(:user) }
    player_2 { create(:user) }
    player_1_score { 21 }
    player_2_score { 15 }
  end
end
