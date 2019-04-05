class FaceoffResultsController < ApplicationController

  def create
    @season = 20182019
    @team1_id = params[:team1_id]
    @team2_id = params[:team2_id]

    @sim_result = python(@season, @team1_id, @team2_id)
    predicted_outcome = predict_winner(@sim_result)

    @faceoff_result = FaceoffResult.new
    @faceoff_result.team1_id = predicted_outcome[:winning_team]
    @faceoff_result.team2_id = predicted_outcome[:losing_team]
    @faceoff_result.team1_percent_chance_win = predicted_outcome[:winning_team_prob]
    @faceoff_result.team2_percent_chance_win = predicted_outcome[:losing_team_prob]
    @faceoff_result.mean_absolute_error = @sim_result[:loss]

    if @faceoff_result.save
      puts @faceoff_result
      redirect_to faceoff_result_path(@faceoff_result.id)
    else
      flash[:danger] = 'Error: Please Select 2 Teams'
      redirect_to "/"
    end
  end

  def show
    @faceoff_result = FaceoffResult.find (params[:id])
    @games = Game.where(status: 'Final')
    @team1 = Team.find (@faceoff_result.team1_id)
    @team2 = Team.find (@faceoff_result.team2_id)
    @series = randomWin(@faceoff_result.team1_percent_chance_win)
    @seriesResult = seriesOutcome(@series, @team1, @team2)

  end

  private

  def python (season, team1, team2)
    { predicted: [0.51, 0.49], loss: 0.56 }
  end

  def predict_winner(sim)
    if @sim_result[:predicted][0] > @sim_result[:predicted][1]
      { winning_team: @team1_id, winning_team_prob: @sim_result[:predicted][0],
        losing_team: @team2_id, losing_team_prob: @sim_result[:predicted][1]
      }
    else
      { winning_team: @team2_id, winning_team_prob: @sim_result[:predicted][1],
        losing_team: @team1_id, losing_team_prob: @sim_result[:predicted][0]
      }
    end
  end

  def randomWin(team1_win_percent)
    winTotal = 0
    loseTotal = 0
    gameTotal = 0

    while gameTotal < 7 do
      win = Random.rand() < team1_win_percent
      gameTotal += 1
      if win
        winTotal += 1
      else
        loseTotal +=1
      end
      break if winTotal == 4 || loseTotal == 4
    end

    { wins: winTotal, losses: loseTotal, games: gameTotal }

  end

  def seriesOutcome(w_l_spread, team1, team2)
    if @series[:wins] > @series[:losses]
      "#{@team1.name} win the series in #{@series[:games]}"
    else
      "#{@team2.name} win the series in #{@series[:games]}"
    end
  end
end

# TODO

# Integrate python "app"