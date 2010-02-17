# == Schema Information
# Schema version: 20100213195716
#
# Table name: users
#
#  id               :integer         not null, primary key
#  email            :string(255)
#  hashed_password  :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#  salt             :string(255)
#  registration_key :string(255)
#  end_date         :datetime
#

require 'digest/sha1'

class User < ActiveRecord::Base
  has_many :schedules
  has_and_belongs_to_many :roles

  validates_presence_of :email
  validates_uniqueness_of :email

  attr_accessor :password_confirmation
  validates_confirmation_of :password

  validate :password_non_blank

  def password
    @password
  end

  def password=(pwd)
    @password = pwd
    return if pwd.blank?
    create_new_salt
    self.hashed_password = User.encrypt_password(self.password, self.salt)
  end

  def self.authenticate(email, password)
    user = self.find_by_email(email)
    if user
      expected_password = encrypt_password(password, user.salt)
      if password_does_not_match(user, expected_password) or 
         user_not_registered(user)
        user = nil
      end
    end
    user
  end

  private
    def self.password_does_not_match(user, expected_password)
      return user.hashed_password != expected_password
    end

    def self.user_not_registered(user)
      return user.registration_key != nil
    end

    def create_new_salt
      self.salt = self.object_id.to_s + rand.to_s
    end

    def password_non_blank
      errors.add(:password, "Missing password") if hashed_password.blank?
    end

    def self.encrypt_password(password, salt)
      string_to_hash = password + "wibble" + salt
      Digest::SHA1.hexdigest(string_to_hash)
    end
end
