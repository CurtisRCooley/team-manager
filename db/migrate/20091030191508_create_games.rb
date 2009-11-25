class CreateGames < ActiveRecord::Migration
  def self.up
    create_table :games do |t|
      t.datetime :game_time
      t.string :location
      t.string :opponent
      t.text :note

      t.timestamps
    end
  end

  def self.down
    drop_table :games
  end
end
