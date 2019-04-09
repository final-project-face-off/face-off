class RecreateTeams < ActiveRecord::Migration[5.2]
  def change
    create_table :teams do |t|
      t.string "name"
      t.integer "gamesPlayed"
      t.integer "wins"
      t.integer "losses"
      t.integer "ot"
      t.integer "pts"
      t.decimal "ptPctg", :precision => 15, :scale => 10
      t.decimal "goalsPerGame", :precision => 15, :scale => 10
      t.decimal "goalsAgainstPerGame", :precision => 15, :scale => 10
      t.decimal "evGGARatio", :precision => 15, :scale => 10
      t.decimal "powerPlayPercentage", :precision => 15, :scale => 10
      t.integer "powerPlayGoals"
      t.integer "powerPlayGoalsAgainst"
      t.integer "powerPlayOpportunities"
      t.decimal "penaltyKillPercentage", :precision => 15, :scale => 10
      t.decimal "shotsPerGame", :precision => 15, :scale => 10
      t.decimal "shotsAllowed", :precision => 15, :scale => 10
      t.decimal "winScoreFirst", :precision => 15, :scale => 10
      t.decimal "winOppScoreFirst", :precision => 15, :scale => 10
      t.decimal "winLeadFirstPer", :precision => 15, :scale => 10
      t.decimal "winLeadSecondPer", :precision => 15, :scale => 10
      t.decimal "winOutshootOpp", :precision => 15, :scale => 10
      t.decimal "winOutshotByOpp", :precision => 15, :scale => 10
      t.decimal "faceOffsTaken", :precision => 15, :scale => 10
      t.integer "faceOffsWon"
      t.integer "faceOffsLost"
      t.decimal "faceOffWinPercentage", :precision => 15, :scale => 10
      t.decimal "shootingPctg", :precision => 15, :scale => 10
      t.decimal "savePctg", :precision => 15, :scale => 10
      t.integer "season"
      t.integer "team_id"
      t.timestamps
    end
  end
end
