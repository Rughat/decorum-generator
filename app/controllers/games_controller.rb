class GamesController < ApplicationController
  def create
    @game = Game.new(game_params)
    @game.save
    redirect_to @game
  end

  def show
    @game = Game.find(params[:id])
  end

  def new
    @game = Game.new()
  end

  def index
  end

  private

  def game_params
    params.permit(:player_count, :id, :authenticity_token)
  end
end
