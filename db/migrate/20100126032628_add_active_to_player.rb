class AddActiveToPlayer < ActiveRecord::Migration
  def self.up
    add_column :players, :reserve, :boolean
  end

  def self.down
    remove_column :players, :reserve
  end
end
