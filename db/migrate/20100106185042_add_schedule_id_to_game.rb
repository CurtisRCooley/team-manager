class AddScheduleIdToGame < ActiveRecord::Migration
  def self.up
    add_column :games, :schedule_id, :integer
    add_column :players, :schedule_id, :integer
    users = User.all
    users.each { |user|
      schedule = Schedule.create(:name => "#{user.email} Schedule", 
                      :notification_days => 4,
                      :user_id => user.id)
      games = Game.find(:all, :conditions => ["user_id = #{user.id}"])
      schedule.games << games 
      games.each { |game|
        game.schedule = schedule
      }
      players = Player.find(:all, :conditions => ["user_id = #{user.id}"])
      schedule.players << players
      players.each { |player|
        player.schedule = schedule
      }
      user.schedules << schedule
    }
    remove_column :games, :user_id
    remove_column :players, :user_id
  end

  def self.down
    add_column :games, :user_id, :integer
    add_column :players, :user_id, :integer
    users = User.all
    users.each {|user|
      user.games << user.schedule.games
      user.schedule.games.each {|game|
        game.user = user
      }
      user.players << user.schedule.players
      user.schedule.players.each {|player|
        player.user = user
      }
    }
    remove_column :games, :schedule_id
    remove_column :players, :schedule_id
  end
end
