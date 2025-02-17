class CreatePlayingStatuses < ActiveRecord::Migration
  def self.up
    create_table :playing_statuses do |t|
      t.integer :player_id
      t.integer :game_id
      t.integer :playing_status

      t.timestamps
    end
  end

  def self.down
    drop_table :playing_statuses
  end
end
