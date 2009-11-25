class UserToPlayerAndGame < ActiveRecord::Migration
  def self.up
    remove_column :users, :player_id
    add_column :games, :user_id, :integer
    add_column :players, :user_id, :integer
  end

  def self.down
    remove_column :games, :user_id
    remove_column :players, :user_id
    add_column :users, :player_id, :integer
  end
end
