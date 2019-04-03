class AddStatusToGames < ActiveRecord::Migration[5.2]
  def change
    add_column :games, :status, :string
  end
end
