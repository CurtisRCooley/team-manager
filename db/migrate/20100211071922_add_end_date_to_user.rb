class AddEndDateToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :end_date, :timestamp
    User.all.each do |user|
      user.end_date = 1.year.from_now
      user.save
    end
  end

  def self.down
    remove_column :users, :end_date
  end
end
