# == Schema Information
# Schema version: 20100106185042
#
# Table name: schedules
#
#  id                :integer         not null, primary key
#  notification_days :integer
#  note              :text
#  minimum_players   :integer
#  name              :string(255)
#  created_at        :datetime
#  updated_at        :datetime
#  user_id           :integer
#

class Schedule < ActiveRecord::Base
  belongs_to :user
  has_many :games
  has_many :players
end
