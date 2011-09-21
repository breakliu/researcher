class AddPopedomToUser < ActiveRecord::Migration
  def change
    add_column :users, :popedom, :integer, :default => 0
  end

  def self.down
    remove_column :users, :popedom
  end
end
