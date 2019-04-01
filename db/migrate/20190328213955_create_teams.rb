class CreateTeams < ActiveRecord::Migration[5.2]
  def change
    create_table :teams do |t|
      t.string "name"
      t.integer "gamesPlayed"
      t.integer "wins"
      t.integer "losses"
      t.integer "ot"
      t.integer "pts"
      t.decimal "ptPctg", :precision => 4, :scale => 2
      t.decimal "goalsPerGame", :precision => 4, :scale => 2
      t.decimal "goalsAgainstPerGame", :precision => 4, :scale => 2
      t.decimal "evGGARatio", :precision => 4, :scale => 2
      t.decimal "powerPlayPercentage", :precision => 4, :scale => 2
      t.integer "powerPlayGoals"
      t.integer "powerPlayGoalsAgainst"
      t.integer "powerPlayOpportunities"
      t.decimal "penaltyKillPercentage", :precision => 4
      t.decimal "shotsPerGame", :precision => 4
      t.decimal "shotsAllowed", :precision => 4
      t.decimal "winScoreFirst", :precision => 4
      t.decimal "winOppScoreFirst", :precision => 4
      t.decimal "winLeadFirstPer", :precision => 4
      t.decimal "winLeadSecondPer", :precision => 4
      t.decimal "winOutshootOpp", :precision => 4
      t.decimal "winOutshotByOpp", :precision => 4
      t.decimal "faceOffsTaken", :precision => 4
      t.integer "faceOffsWon"
      t.integer "faceOffsLost"
      t.decimal "faceOffWinPercentage", :precision => 4
      t.decimal "shootingPctg", :precision => 4
      t.decimal "savePctg", :precision => 4

      t.timestamps
    end
  end
end
