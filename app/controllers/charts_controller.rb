class ChartsController < ApplicationController

    def show
        @teams = Team.all
    end
    
end
