require 'open3'
require 'json'

# TODO
# Add Loss to DB and display on page

class FaceoffResultsController < ApplicationController

  def create
    # Variables collected from the select submission & always use 2018-2019 as the season
    @season = 20182019
    @team1_id = params[:team1_id]
    @team2_id = params[:team2_id]

    # Send the variables to the neural network
    @sim_result = python(@season, @team1_id, @team2_id)
    # Parse the results from the neural network
    @parsed_sim = JSON.parse(@sim_result,  symbolize_names: true) #=> {key: :value}
    # Send the parsed hash to evaluate the winner based on the "predicted" value
    predicted_outcome = predict_winner()

    # Create a new Faceoff Result based on the predicted winner hash & stats from the parsed sim
    @faceoff_result = FaceoffResult.new
    @faceoff_result.team1_id = predicted_outcome[:winning_team]
    @faceoff_result.team2_id = predicted_outcome[:losing_team]
    @faceoff_result.team1_percent_chance_win = predicted_outcome[:winning_team_prob]
    @faceoff_result.team2_percent_chance_win = predicted_outcome[:losing_team_prob]
    @faceoff_result.mean_absolute_error = @parsed_sim[:loss]

    # Handle errors
    if @faceoff_result.save
      redirect_to faceoff_result_path(@faceoff_result.id)
    else
      flash[:danger] = 'Error: Please Select 2 Teams'
      redirect_to "/"
    end
  end

  def show
    # Display Faceoff Results from the DB
    @faceoff_result = FaceoffResult.find (params[:id])
    @team1 = Team.find (@faceoff_result.team1_id)
    @team2 = Team.find (@faceoff_result.team2_id)

    # Predict a weighted random winner based on winning team's probability of winning
    @series = randomWin(@faceoff_result.team1_percent_chance_win)
    # Reformats the weighted random win results as a string
    @seriesResult = seriesOutcome(@series, @team1, @team2)

    # Displays the recent game results
    @games = Game.where(status: 'Final')

  end

  private

  def python (season, team1, team2)
    output, status = Open3.capture2("algo/neuralnet.py", "#{team1}", "#{team2}", "#{season}")
    output
    # puts "###############"
    # puts output
    # puts "###############"
    # expexted output { "predicted": 0.9605167193846802, "mae": 0.0394832806153198, "loss": 0.001558929448148088 }
  end

  def predict_winner()
    # Team 2 predicted probability is determined by subtracting team 1's probability from 1 (to equal 100%)
    team2_prob = 1 - @parsed_sim[:predicted]

    # Evaluate the winning team and return a hash
    if @parsed_sim[:predicted] > team2_prob
      { winning_team: @team1_id, winning_team_prob: @parsed_sim[:predicted],
        losing_team: @team2_id, losing_team_prob: team2_prob }
    else
      { winning_team: @team2_id, winning_team_prob: team2_prob,
        losing_team: @team1_id, losing_team_prob: @parsed_sim[:predicted]}
    end
  end

  def randomWin(team1_win_percent)
    winTotal = 0
    loseTotal = 0
    gameTotal = 0

    # Generates a game outcome based on team 1's win probability
    # No more than 7 games played
    while gameTotal < 7 do
      # Each game has individual weighted random result
      win = Random.rand() < team1_win_percent
      gameTotal += 1
      if win
        winTotal += 1
      else
        loseTotal +=1
      end
      # First team to 4 wins wins the series
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

