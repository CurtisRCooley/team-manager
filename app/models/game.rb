# == Schema Information
# Schema version: 20100106181943
#
# Table name: games
#
#  id         :integer         not null, primary key
#  game_time  :datetime
#  location   :string(255)
#  opponent   :string(255)
#  note       :text
#  created_at :datetime
#  updated_at :datetime
#  user_id    :integer
#

class Game < ActiveRecord::Base
  belongs_to :schedule
  has_many :playing_statuses
  has_many :players, :through => :playing_statuses
end
