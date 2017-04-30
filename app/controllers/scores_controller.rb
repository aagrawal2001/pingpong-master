class ScoresController < ApplicationController
  def index
    @scores = Score.ranked_players
  end
end
