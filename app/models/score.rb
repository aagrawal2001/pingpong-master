class Score < ActiveRecord::Base
  belongs_to :user

  validates :user, presence: true
  validates :score, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :games_played, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def self.create_entry_for_user(user)
    score = Score.new
    score.user = user
    score.score = 0
    score.games_played =0
    score.save!
  end

  def self.update_scores_from_game_result(game)
    Score.transaction do
      player_1_score = Score.where(user_id: game.player_1_id).first
      player_2_score = Score.where(user_id: game.player_2_id).first
      player_1_rank = players_with_higher_score(player_1_score.score) + 1
      player_2_rank = players_with_higher_score(player_2_score.score) + 1

      if game.winner == game.player_1
        winner_rank = player_1_rank
        loser_rank = player_2_rank
        winning_player_score = player_1_score
      else
        winner_rank = player_2_rank
        loser_rank = player_1_rank
        winning_player_score = player_2_score
      end

      # Each winner receives 100 points.
      # However, in the case of an upset i.e. if the winner has a lower rank than his/her opponent,
      # the winner is awarded a bonus equal to 100 times the difference in their ranks.
      # Example: If player with rank 1 defeats player with rank 3, winner receives 100 points
      # and no bonus points, making a total of 100
      # But if player with rank 3 defeats player with rank 1, winner receives 100 points plus
      # 200 bonus points for a total of 300
      points = 100
      if winner_rank > loser_rank
        points += 100 * (winner_rank - loser_rank)
      end
      winning_player_score.score += points

      player_1_score.games_played += 1
      player_2_score.games_played += 1

      player_1_score.save!
      player_2_score.save!
    end
  end

  def self.ranked_players
    order(score: :desc)
  end

  private

  def self.players_with_higher_score(score)
    Score.where('score > ?', score).count
  end
end
