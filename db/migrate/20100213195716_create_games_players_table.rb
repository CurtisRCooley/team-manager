class CreateGamesPlayersTable < ActiveRecord::Migration
  def self.up
    create_table :games_players, :id => false do |t|
      t.integer :game_id, :null => false
      t.integer :player_id, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :games_players
  end
end
