class GamesController < ApplicationController
  def create
    @game = Game.build(player_count: game_params[:player_count].to_i)
    redirect_to game_url(@game)
  end

  def show
    @game = Game.find(params[:id])
  end

  def new
    @game = Game.new
  end

  def index
  end

  private

  def game_params
    params.fetch(:game, {})
  end
end
