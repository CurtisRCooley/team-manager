# == Schema Information
# Schema version: 20100106185042
#
# Table name: players
#
#  id          :integer         not null, primary key
#  name        :string(255)
#  email       :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  schedule_id :integer
#

class Player < ActiveRecord::Base
  belongs_to :schedule
  has_many :playing_statuses
  has_many :games, :through => :playing_statuses
end
