class ChangeUsersPosts < ActiveRecord::Migration
  def change
    drop_table :users_posts
    create_table :users_posts do |t|
      t.integer :user_id, :null => false
      t.integer :post_id, :null => false
      t.integer :operate_post_flag, :default => 0

      t.timestamps
    end
  end

  def down

  end
end
