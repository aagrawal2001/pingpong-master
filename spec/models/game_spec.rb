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

  it "updates scores after each game is created" do
    expect(Score).to receive(:update_scores_from_game_result)
    create(:game)
  end

  describe "#winner" do
    subject { game.winner }

    it "returns player 1 if player 1 was the winner" do
      expect(subject).to eq(game.player_1)
    end

    context 'when player 2 is the winner' do
      let(:game) { create(:game, player_1_score: 5, player_2_score: 21) }

      it 'returns player 2' do
        expect(subject).to eq(game.player_2)
      end
    end
  end

  describe ".including_user" do
    subject { described_class.including_user(user_id) }

    context "when a game has player 1 as the user id" do
      let(:user_id) { game.player_1_id }

      it "returns the game" do
        expect(subject).to eq([game])
      end
    end

    context "when a game has player 2 as the user id" do
      let(:user_id) { game.player_2_id }

      it "returns the game" do
        expect(subject).to eq([game])
      end
    end
  end

  describe "#opponent" do
    subject { game.opponent(player) }

    context "when player passed in is player 1" do
      let(:player) { game.player_1 }

      it "returns player 2" do
        expect(subject).to eq(game.player_2)
      end
    end

    context "when player passed in is player 2" do
      let(:player) { game.player_2 }

      it "returns player 1" do
        expect(subject).to eq(game.player_1)
      end
    end
  end

  describe "#player_score" do
    subject { game.player_score(player) }

    context "when player passed in is player 1" do
      let(:player) { game.player_1 }

      it "returns player 1's score" do
        expect(subject).to eq(game.player_1_score)
      end
    end

    context "when player passed in is player 2" do
      let(:player) { game.player_2 }

      it "returns player 2's score" do
        expect(subject).to eq(game.player_2_score)
      end
    end
  end
end
