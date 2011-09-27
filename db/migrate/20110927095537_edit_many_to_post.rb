class EditManyToPost < ActiveRecord::Migration
  def change
    remove_column :posts, :user_id
    remove_column :posts, :owner_id
  end
end
