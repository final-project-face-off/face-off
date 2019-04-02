require 'rest-client'
require 'rails/configuration'

PastTeam.delete_all
ActiveRecord::Base.connection.reset_pk_sequence!(:teams)

#NHL API endpoint
  season20092010_url = "https://statsapi.web.nhl.com/api/v1/teams?expand=team.stats&season=20092010"
  season20102011_url = "https://statsapi.web.nhl.com/api/v1/teams?expand=team.stats&season=20102011"
  season20112012_url = "https://statsapi.web.nhl.com/api/v1/teams?expand=team.stats&season=20112012"
  season20122013_url = "https://statsapi.web.nhl.com/api/v1/teams?expand=team.stats&season=20122013"
  season20132014_url = "https://statsapi.web.nhl.com/api/v1/teams?expand=team.stats&season=20132014"
  season20142015_url = "https://statsapi.web.nhl.com/api/v1/teams?expand=team.stats&season=20142015"
  season20152016_url = "https://statsapi.web.nhl.com/api/v1/teams?expand=team.stats&season=20152016"
  season20162017_url = "https://statsapi.web.nhl.com/api/v1/teams?expand=team.stats&season=20162017"
  season20172018_url = "https://statsapi.web.nhl.com/api/v1/teams?expand=team.stats&season=20172018"

#RestClient get request to the NHL endpoint being parsed into a JS object
  season20092010 = JSON.parse( RestClient.get("#{season20092010_url}") )
  season20102011 = JSON.parse( RestClient.get("#{season20102011_url}") )
  season20112012 = JSON.parse( RestClient.get("#{season20112012_url}") )
  season20122013 = JSON.parse( RestClient.get("#{season20122013_url}") )
  season20132014 = JSON.parse( RestClient.get("#{season20132014_url}") )
  season20142015 = JSON.parse( RestClient.get("#{season20142015_url}") )
  season20152016 = JSON.parse( RestClient.get("#{season20152016_url}") )
  season20162017 = JSON.parse( RestClient.get("#{season20162017_url}") )
  season20172018 = JSON.parse( RestClient.get("#{season20172018_url}") )

  #Iterating through each team
  season20092010["teams"].each do |team, index|
    #Creating a new team in my database and assigning it's properties
    team = PastTeam.new do |key|
      key.team_id = team["id"]
      key.season = 20092010
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
      puts "saved pastTeam"
    else
      puts "not saved"
    end
  end

  #Iterating through each team
  season20102011["teams"].each do |team, index|
    #Creating a new team in my database and assigning it's properties
    team = PastTeam.new do |key|
      key.team_id = team["id"]
      key.season = 20102011
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
      puts "saved pastTeam"
    else
      puts "not saved"
    end
  end

  #Iterating through each team
  season20112012["teams"].each do |team, index|
    #Creating a new team in my database and assigning it's properties
    team = PastTeam.new do |key|
      key.team_id = team["id"]
      key.season = 20112012
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
      puts "saved pastTeam"
    else
      puts "not saved"
    end
  end

  #Iterating through each team
  season20122013["teams"].each do |team, index|
    #Creating a new team in my database and assigning it's properties
    team = PastTeam.new do |key|
      key.team_id = team["id"]
      key.season = 20122013
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
      puts "saved pastTeam"
    else
      puts "not saved"
    end
  end

  #Iterating through each team
  season20132014["teams"].each do |team, index|
    #Creating a new team in my database and assigning it's properties
    team = PastTeam.new do |key|
      key.team_id = team["id"]
      key.season = 20132014
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
      puts "saved pastTeam"
    else
      puts "not saved"
    end
  end

  #Iterating through each team
  season20142015["teams"].each do |team, index|
    #Creating a new team in my database and assigning it's properties
    team = PastTeam.new do |key|
      key.team_id = team["id"]
      key.season = 20142015
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
      puts "saved pastTeam"
    else
      puts "not saved"
    end
  end

  #Iterating through each team
  season20152016["teams"].each do |team, index|
    #Creating a new team in my database and assigning it's properties
    team = PastTeam.new do |key|
      key.team_id = team["id"]
      key.season = 20152016
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
      puts "saved pastTeam"
    else
      puts "not saved"
    end
  end

  #Iterating through each team
  season20162017["teams"].each do |team, index|
    #Creating a new team in my database and assigning it's properties
    team = PastTeam.new do |key|
      key.team_id = team["id"]
      key.season = 20162017
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
      puts "saved pastTeam"
    else
      puts "not saved"
    end
  end

  #Iterating through each team
  season20172018["teams"].each do |team, index|
    #Creating a new team in my database and assigning it's properties
    team = PastTeam.new do |key|
      key.team_id = team["id"]
      key.season = 20172018
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
      puts "saved pastTeam"
    else
      puts "not saved"
    end
  end