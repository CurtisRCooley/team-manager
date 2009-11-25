# == Schema Information
# Schema version: 20091112014219
#
# Table name: players
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#  user_id    :integer
#

class Player < ActiveRecord::Base
  belongs_to :user
end
