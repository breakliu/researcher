class AddManyToUser < ActiveRecord::Migration
  def change
    add_column :users, :age, :integer
    add_column :users, :level, :string
    add_column :users, :major, :string
    add_column :users, :subject, :string
    add_column :users, :phone, :string
  end

  def down
    remove_column :users, :age
    remove_column :users, :level
    remove_column :users, :major
    remove_column :users, :subject
    remove_column :users, :phone
  end
end
