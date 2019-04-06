class ChartsController < ApplicationController

    

    def show
        @team = PastTeam.where(team_id: 1).group('id').order('season').group('season')
    end
    
end
