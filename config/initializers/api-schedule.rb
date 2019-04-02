require 'rest-client'
require 'rails/configuration'

Game.delete_all
ActiveRecord::Base.connection.reset_pk_sequence!(:game)

#NHL API endpoint
  nhl_url = "https://statsapi.web.nhl.com/api/v1/schedule"

#RestClient get request to the NHL endpoint parsed into a JS object
  data = JSON.parse( RestClient.get("#{nhl_url}") )

#Iterating through each NHL team
  data["dates"][0]["games"].each do |game, index|
    #Creating a new game in my database and assigning it's properties
    game = Game.new do |key|
      key.gameDate = game["gameDate"]
      key.awayID = game["teams"]["away"]["team"]["id"]
      key.awayScore = game["teams"]["away"]["score"]
      key.awayName = game["teams"]["away"]["team"]["name"]
      key.homeID = game["teams"]["home"]["team"]["id"]
      key.homeScore = game["teams"]["home"]["score"]
      key.homeName = game["teams"]["home"]["team"]["name"]
    end
    #Saving games
    if game.save
      puts "saved today's game"
    else
      puts "not saved"
    end
  end

#Calculate yesterday's date
date = Time.now - 86400
yesterday = date.strftime("%Y-%m-%d")

#NHL API endpoint for yesterdays games
nhl_results_url = "https://statsapi.web.nhl.com/api/v1/schedule?date=#{yesterday}"

#RestClient get request to the NHL endpoint parsed into a JS object
  data = JSON.parse( RestClient.get("#{nhl_results_url}") )

#Iterating through each NHL team
  data["dates"][0]["games"].each do |game, index|
    #Creating a new game in my database and assigning it's properties
    game = Game.new do |key|
      key.gameDate = game["gameDate"]
      key.awayID = game["teams"]["away"]["team"]["id"]
      key.awayScore = game["teams"]["away"]["score"]
      key.awayName = game["teams"]["away"]["team"]["name"]
      key.homeID = game["teams"]["home"]["team"]["id"]
      key.homeScore = game["teams"]["home"]["score"]
      key.homeName = game["teams"]["home"]["team"]["name"]
    end
    #Saving games
    if game.save
      puts "saved yesterday's game"
    else
      puts "not saved"
    end
  end