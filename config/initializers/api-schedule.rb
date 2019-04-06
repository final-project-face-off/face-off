require 'rest-client'
require 'rails/configuration'

Game.delete_all
ActiveRecord::Base.connection.reset_pk_sequence!(:game)

#TODAY'S GAMES

#today's date
date = Time.now
today = date.strftime("%Y-%m-%d")

#NHL API endpoint => TODAY
nhl_url = "https://statsapi.web.nhl.com/api/v1/schedule?date=#{today}"

#RestClient get request to the NHL endpoint parsed into a JS object
data = JSON.parse( RestClient.get("#{nhl_url}") )

#Iterating through each NHL team
  data["dates"][0]["games"].each do |game, index|
    #Creating a new game in my database and assigning it's properties
    game = Game.new do |key|
      key.gameDate = today
      key.awayID = game["teams"]["away"]["team"]["id"]
      key.awayScore = game["teams"]["away"]["score"]
      key.awayName = game["teams"]["away"]["team"]["name"]
      key.homeID = game["teams"]["home"]["team"]["id"]
      key.homeScore = game["teams"]["home"]["score"]
      key.homeName = game["teams"]["home"]["team"]["name"]
      key.status = game["status"]["detailedState"]
    end
    #Saving games
    if game.save
      puts "saved today's game"
    else
      puts "not saved"
    end
  end


#YESTERDAY'S GAMES

#Calculate yesterday's date
date = Time.now - 86400
yesterday = date.strftime("%Y-%m-%d")

#NHL API endpoint for yesterdays games
nhl_url = "https://statsapi.web.nhl.com/api/v1/schedule?date=#{yesterday}"

#RestClient get request to the NHL endpoint parsed into a JS object
data = JSON.parse( RestClient.get("#{nhl_url}") )

#Iterating through each NHL team
  data["dates"][0]["games"].each do |game, index|
    #Creating a new game in my database and assigning it's properties
    game = Game.new do |key|
      key.gameDate = yesterday
      key.awayID = game["teams"]["away"]["team"]["id"]
      key.awayScore = game["teams"]["away"]["score"]
      key.awayName = game["teams"]["away"]["team"]["name"]
      key.homeID = game["teams"]["home"]["team"]["id"]
      key.homeScore = game["teams"]["home"]["score"]
      key.homeName = game["teams"]["home"]["team"]["name"]
      key.status = game["status"]["detailedState"]
    end
    #Saving games
    if game.save
      puts "saved yesterday's game"
    else
      puts "not saved"
    end
  end


# #TOMORROW'S GAMES

# #Calculate tomorrow's date
# date = Time.now + 86400
# tomorrow = date.strftime("%Y-%m-%d")

# #NHL API endpoint for yesterdays games
# nhl_url = "https://statsapi.web.nhl.com/api/v1/schedule?date=#{tomorrow}"

# #RestClient get request to the NHL endpoint parsed into a JS object
# data = JSON.parse( RestClient.get("#{nhl_url}") )

# #Iterating through each NHL team
#   data["dates"][0]["games"].each do |game, index|
#     #Creating a new game in my database and assigning it's properties
#     game = Game.new do |key|
#       key.gameDate = tomorrow
#       key.awayID = game["teams"]["away"]["team"]["id"]
#       key.awayScore = game["teams"]["away"]["score"]
#       key.awayName = game["teams"]["away"]["team"]["name"]
#       key.homeID = game["teams"]["home"]["team"]["id"]
#       key.homeScore = game["teams"]["home"]["score"]
#       key.homeName = game["teams"]["home"]["team"]["name"]
#       key.status = game["status"]["detailedState"]
#     end
#     #Saving games
#     if game.save
#       puts "saved tomorrow's game"
#     else
#       puts "not saved"
#     end
#   end