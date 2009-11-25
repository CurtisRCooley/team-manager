class AddRegisterValidation < ActiveRecord::Migration
  def self.up
    add_column :users, :registration_key, :string
  end

  def self.down
    remove_column :users, :registration_key
  end
end
