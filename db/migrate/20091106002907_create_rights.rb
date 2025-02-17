class CreateRights < ActiveRecord::Migration
  def self.up
    create_table :rights do |t|
      t.column "name", :string
      t.column "controller", :string
      t.column "action", :string

      t.timestamps
    end
  end

  def self.down
    drop_table :rights
  end
end
