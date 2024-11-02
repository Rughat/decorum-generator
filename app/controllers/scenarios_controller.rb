class ScenariosController < ApplicationController
  def create
    if Rails.env.development? || verify_recaptcha(model: @user)
      @scenario = Scenario.build(player_count: params[:player_count].to_i, requirement_count: params[:requirement_count].to_i)
      redirect_to scenario_url(@scenario)
    else
      render 'new'
    end
  end

  def show
    @scenario = Scenario.find(params[:id])
  end

  def new
    @scenario = Scenario.new
  end

  def index
    @scenarios = Scenario.all.sort_by(&:id).reverse
  end

  private

  def scenario_params
    params.permit(:player_count, :requirement_count)
  end
end
