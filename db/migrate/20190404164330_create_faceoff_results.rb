class CreateFaceoffResults < ActiveRecord::Migration[5.2]
  def change
    create_table :faceoff_results do |t|
      t.integer "team1_id"
      t.decimal "team1_percent_chance_win", precision: 10, scale: 2
      t.integer "team2_id"
      t.decimal "team2_percent_chance_win", precision: 10, scale: 2
      t.decimal "mean_absolute_error", precision: 10, scale: 2
      t.timestamps
    end
  end
end