class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
      t.date "gameDate"
      t.integer "awayID"
      t.integer "awayScore"
      t.string "awayName"
      t.integer "homeID"
      t.integer "homeScore"
      t.string "homeName"

      t.timestamps
    end
  end
end
