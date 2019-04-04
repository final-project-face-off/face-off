class HomeController < ApplicationController
  def index
    @teams = Team.all
    @games = Game.where(status: 'Scheduled')
  end
end
