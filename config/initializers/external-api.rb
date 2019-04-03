require 'rest-client'
require 'rails/configuration'

Team.delete_all
ActiveRecord::Base.connection.reset_pk_sequence!(:teams)

#NHL API endpoint
  nhl_url = "https://statsapi.web.nhl.com/api/v1/teams?expand=team.stats"

#RestClient get request to the NHL endpoint parsed into a JS object
  data = JSON.parse( RestClient.get("#{nhl_url}") )

#Iterating through each NHL team
  data["teams"].each do |team, index|
    #Creating a new team in my database
    team = Team.new do |key|
      key.id = team["id"]
      key.team_id = team["id"]
      key.season = 20182019
      key.name = team["name"]
      key.gamesPlayed = team["teamStats"][0]["splits"][0]["stat"]["gamesPlayed"]
      key.wins = team["teamStats"][0]["splits"][0]["stat"]["wins"]
      key.losses = team["teamStats"][0]["splits"][0]["stat"]["losses"]
      key.ot = team["teamStats"][0]["splits"][0]["stat"]["ot"]
      key.pts = team["teamStats"][0]["splits"][0]["stat"]["pts"]
      key.ptPctg = team["teamStats"][0]["splits"][0]["stat"]["ptPctg"]
      key.goalsPerGame = team["teamStats"][0]["splits"][0]["stat"]["goalsPerGame"]
      key.goalsAgainstPerGame = team["teamStats"][0]["splits"][0]["stat"]["goalsAgainstPerGame"]
      key.evGGARatio = team["teamStats"][0]["splits"][0]["stat"]["evGGARatio"]
      key.powerPlayPercentage = team["teamStats"][0]["splits"][0]["stat"]["powerPlayPercentage"]
      key.powerPlayGoals = team["teamStats"][0]["splits"][0]["stat"]["powerPlayGoals"]
      key.powerPlayGoalsAgainst = team["teamStats"][0]["splits"][0]["stat"]["powerPlayGoalsAgainst"]
      key.powerPlayOpportunities = team["teamStats"][0]["splits"][0]["stat"]["powerPlayOpportunities"]
      key.penaltyKillPercentage = team["teamStats"][0]["splits"][0]["stat"]["penaltyKillPercentage"]
      key.shotsPerGame = team["teamStats"][0]["splits"][0]["stat"]["shotsPerGame"]
      key.shotsAllowed = team["teamStats"][0]["splits"][0]["stat"]["shotsAllowed"]
      key.winScoreFirst = team["teamStats"][0]["splits"][0]["stat"]["winScoreFirst"]
      key.winOppScoreFirst = team["teamStats"][0]["splits"][0]["stat"]["winOppScoreFirst"]
      key.winLeadFirstPer = team["teamStats"][0]["splits"][0]["stat"]["winLeadFirstPer"]
      key.winLeadSecondPer = team["teamStats"][0]["splits"][0]["stat"]["winLeadSecondPer"]
      key.winOutshootOpp = team["teamStats"][0]["splits"][0]["stat"]["winOutshootOpp"]
      key.winOutshotByOpp = team["teamStats"][0]["splits"][0]["stat"]["winOutshotByOpp"]
      key.faceOffsTaken = team["teamStats"][0]["splits"][0]["stat"]["faceOffsTaken"]
      key.faceOffsWon = team["teamStats"][0]["splits"][0]["stat"]["faceOffsWon"]
      key.faceOffsLost = team["teamStats"][0]["splits"][0]["stat"]["faceOffsLost"]
      key.faceOffWinPercentage = team["teamStats"][0]["splits"][0]["stat"]["faceOffWinPercentage"]
      key.shootingPctg = team["teamStats"][0]["splits"][0]["stat"]["shootingPctg"]
      key.savePctg = team["teamStats"][0]["splits"][0]["stat"]["savePctg"]
    end
    #Saving teams
    if team.save
      puts "saved team"
    else
      puts "not saved"
    end
  end