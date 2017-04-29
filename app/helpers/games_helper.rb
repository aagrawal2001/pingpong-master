module GamesHelper
  def format_date(game)
    game.date.strftime("%B %e, %Y")
  end

  def format_opponent(game)
    game.opponent(current_user).email
  end

  def format_score(game)
    my_score = game.player_score(current_user)
    opponent = game.opponent(current_user)
    opponent_score = game.player_score(opponent)
    "#{my_score} - #{opponent_score}"
  end

  def format_result(game)
    winner = game.winner
    winner == current_user ? 'W' : 'L'
  end
end
