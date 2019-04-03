class ComparisonsController < ApplicationController

    def show
        # puts params[:team_1]
        @team1 = Team.find(params[:team_1]) || Team.find(1)
        puts @team1
        @team2 = Team.find(params[:team_2]) || Team.find(2)
        @teams = Team.all
    end

end
