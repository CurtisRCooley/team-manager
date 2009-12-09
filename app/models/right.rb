# == Schema Information
# Schema version: 20091129194440
#
# Table name: rights
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  controller :string(255)
#  action     :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Right < ActiveRecord::Base
  has_and_belongs_to_many :roles

  def to_s
    "Name: #{name} - Controller: #{controller} - Action: #{action}"
  end
end
