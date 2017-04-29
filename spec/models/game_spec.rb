describe Game, type: :model  do
  let(:game) { create(:game) }

  it "creates a valid factory instance" do
    expect(game).to be_valid
  end

  it { is_expected.to validate_presence_of(:date) }
  it { is_expected.to validate_presence_of(:player_1) }
  it { is_expected.to validate_presence_of(:player_2) }
  it { is_expected.to validate_presence_of(:player_1_score) }
  it { is_expected.to validate_presence_of(:player_2_score) }

  it do
    is_expected.to validate_numericality_of(:player_1_score).
      only_integer.
      is_greater_than_or_equal_to(0)
  end

  it do
    is_expected.to validate_numericality_of(:player_2_score).
      only_integer.
      is_greater_than_or_equal_to(0)
  end

  it "validates that player 1 and 2 are different" do
    game.player_1 = game.player_2
    expect(game).not_to be_valid
  end

  it "validates that at least one player has a score of 21 or higher" do
    game.player_1_score = 20
    game.player_2_score = 10
    expect(game).not_to be_valid
  end

  it "validates that the difference in scores is at least 2" do
    game.player_1_score = 21
    game.player_2_score = 20
    expect(game).not_to be_valid
  end
end
