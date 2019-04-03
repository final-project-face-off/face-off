class ComparisonsController < ApplicationController

    def show
        
        @team1 = params[:team_1] ? Team.find(params[:team_1]) : Team.find(1)
        # @team1 = Team.find(params[:team_1]) || Team.find(1)
        
        @team2 = params[:team_2] ? Team.find(params[:team_2]) : Team.find(2)
        # @team2 = Team.find(params[:team_2]) || Team.find(2)
        
        @teams = Team.all
        
    end

end
