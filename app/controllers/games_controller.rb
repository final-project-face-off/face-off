class GamesController < ApplicationController
  def show
    @games = Game.where(status: 'Scheduled')
  end
end
