# == Schema Information
# Schema version: 20100213195716
#
# Table name: games
#
#  id          :integer         not null, primary key
#  game_time   :datetime
#  location    :string(255)
#  opponent    :string(255)
#  note        :text
#  created_at  :datetime
#  updated_at  :datetime
#  schedule_id :integer
#

class Game < ActiveRecord::Base
  belongs_to :schedule
  has_many :playing_statuses
  has_many :players, :through => :playing_statuses
  has_many :reserves,
  	   :source => :players_games,
           :foreign_key => :player_id
end
