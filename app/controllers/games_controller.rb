class GamesController < ApplicationController
  def new
    @game = Game.new
  end

  def create
    @game = Game.new(game_params)
    @game.player_1 = current_user
    @game.player_2 = User.find(params[:game][:player_2_id])

    if @game.save
      redirect_to games_path
    else
      render :new
    end
  end

  def index
    @games = Game.including_user(current_user.id)
  end

  private

  def game_params
    params.require(:game).permit(:date, :player_1_score, :player_2_score)
  end
end
