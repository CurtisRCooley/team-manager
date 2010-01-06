class CreateSchedules < ActiveRecord::Migration
  def self.up
    create_table :schedules do |t|
      t.integer :notification_days
      t.text :note
      t.integer :minimum_players
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :schedules
  end
end
