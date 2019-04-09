class DropTeamsPastTeams < ActiveRecord::Migration[5.2]
  def change
    drop_table :teams
    drop_table :past_teams
  end
end
