class FaceoffResultsController < ApplicationController

  def create
    @season = 20182019
    @team1_id = params[:team1_id]
    @team2_id = params[:team2_id]

    calculation = python(@season, @team1_id, @team2_id)

    @faceoff_result = FaceoffResult.new
    @faceoff_result.team1_id = @team1_id
    @faceoff_result.team2_id = @team2_id
    @faceoff_result.team1_percent_chance_win = calculation[0]
    @faceoff_result.team2_percent_chance_win = calculation[1]
    @faceoff_result.mean_absolute_error = calculation[2]

    if @faceoff_result.save
      redirect_to faceoff_result_path(@faceoff_result.id)
    else
      flash[:danger] = 'Error: Please Select 2 Teams'
      redirect_to "/"
    end
  end

  def show
    @faceoff_result = FaceoffResult.find (params[:id])
    @team1 = Team.find (@faceoff_result.team1_id)
    @team2 = Team.find (@faceoff_result.team2_id)
    @games = Game.where(status: 'Final')
  end

  private

  def python (season, team1_id, team2_id)
    calcArr = [0.9, 0.1, 0.2]
  end
end

# TODO

# Mean Absolute Error format??
# Error handling for no selection (required input values)
# Logic to show if team1 or team2 wins
# Logic to predict series outcome
# Integrate python "app"