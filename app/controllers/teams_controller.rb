class TeamsController < ApplicationController

  def index
    @teams = Team.all
  end

  def show
    @team = Team.find params[:id]
    @pastTeam = PastTeam.where(team_id: params[:id]).group('id').order('season').group('season')
    @teamGoals = Team.find params[:id]
  end
end
