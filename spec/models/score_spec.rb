describe Score, type: :model do
  let(:user_1) { FactoryGirl.create(:user) }
  let(:user_2) { FactoryGirl.create(:user) }
  let(:user_3) { FactoryGirl.create(:user) }
  let(:score_1) { Score.where(user_id: user_1.id).first }
  let(:score_2) { Score.where(user_id: user_2.id).first }
  let(:score_3) { Score.where(user_id: user_3.id).first }

  describe ".update_scores_from_game_result" do
    before do
      score_1.score = 900
      score_2.score = 800
      score_3.score = 500
      score_1.save!
      score_2.save!
      score_3.save!
    end

    context "when the winner's rank is higher than the loser's rank" do
      let!(:game) do
        create(
          :game,
          player_1: score_1.user,
          player_2: score_3.user,
          player_1_score: 21,
          player_2_score: 15
        )
      end

      it "the winner receives 100 points" do
        subject
        score_1.reload
        expect(score_1.score).to eq(1000)
      end
    end

    context "when the loser's rank is higher than the winner's rank" do
      let!(:game) do
        create(
          :game,
          player_1: score_1.user,
          player_2: score_3.user,
          player_2_score: 21,
          player_1_score: 15
        )
      end

      it "the winner receives 300 points" do
        subject
        score_3.reload
        expect(score_3.score).to eq(800)
      end
    end
  end

  describe ".ranked_players" do
    before do
      score_1.score = 800
      score_2.score = 500
      score_3.score = 900
      score_1.save!
      score_2.save!
      score_3.save!
    end

    it "returns players ranked in descending order of score" do
      expect(described_class.ranked_players).to eq([score_3, score_1, score_2])
    end
  end
end
