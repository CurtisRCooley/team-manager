# == Schema Information
# Schema version: 20100213195716
#
# Table name: roles
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Role < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_and_belongs_to_many :rights

  def to_s
    name
  end
end
