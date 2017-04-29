class Game < ActiveRecord::Base
  belongs_to :player_1, class_name: 'User'
  belongs_to :player_2, class_name: 'User'

  # Validations
  validates :date, presence: true
  validates :player_1, presence: true
  validates :player_2, presence: true
  validates :player_1_score, presence: true
  validates :player_2_score, presence: true
  validates :player_1_score, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :player_2_score, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  validate :players_are_different, :there_is_a_winner

  def winner
    player_1_score >= WINNING_SCORE ? player_1 : player_2
  end

  private

  def players_are_different
    return unless player_1
    if player_1 == player_2
      errors.add(:player_1, "must be different from player 2")
    end
  end

  WINNING_SCORE = 21
  MIN_SCORE_GAP_FOR_WIN = 2

  def there_is_a_winner
    return unless player_1_score
    return unless player_2_score

    # At least one player must score 21
    if player_1_score < WINNING_SCORE && player_2_score < WINNING_SCORE
      errors.add(:base, "at least one player must score 21 or higher")
    end

    # One player must win by a substantial margin
    if (player_1_score - player_2_score).abs < MIN_SCORE_GAP_FOR_WIN
      errors.add(:base, "the difference in scores must be at least #{MIN_SCORE_GAP_FOR_WIN}")
    end
  end
end

