class ScenariosController < ApplicationController
  def create
    @scenario = Scenario.build(player_count: scenario_params[:player_count].to_i)
    redirect_to scenario_url(@scenario)
  end

  def show
    @scenario = Scenario.find(params[:id])
  end

  def new
    @scenario = Scenario.new
  end

  def index
  end

  private

  def scenario_params
    params.permit(:player_count)
  end
end
