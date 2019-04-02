require 'rest-client'
require 'rails/configuration'

Game.delete_all
ActiveRecord::Base.connection.reset_pk_sequence!(:game)

#New York Times API endpoint
  nhl_url = "https://statsapi.web.nhl.com/api/v1/schedule"

#RestClient get request to the NYT endpoint with my API Key being parsed into a JS object
  data = JSON.parse( RestClient.get("#{nhl_url}") )

#Iterating through each result/article of the NYT
  data["dates"][0]["games"].each do |game, index|
    # #finding existing games
    # existing_article = Article.find_by(headline: article["title"])
    #Creating a new article in my database and assigning it's properties
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
      puts "saved game"
    else
      puts "not saved"
    end
  end