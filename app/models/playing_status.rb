# == Schema Information
# Schema version: 20100126032628
#
# Table name: playing_statuses
#
#  id             :integer         not null, primary key
#  player_id      :integer
#  game_id        :integer
#  playing_status :integer
#  created_at     :datetime
#  updated_at     :datetime
#

class PlayingStatus < ActiveRecord::Base
  belongs_to :player
  belongs_to :game

  PLAYING = 1
  NOT_PLAYING = 0
end
