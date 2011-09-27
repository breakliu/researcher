class CreateUsersPosts < ActiveRecord::Migration
  def change
    create_table :users_posts, :id => false, :force => true do |t|
      t.integer :user_id, :null => false
      t.integer :post_id, :null => false
      t.boolean :is_creator, :default => false

      t.timestamps
    end
  end

  def down
    drop_table :users_posts
  end
end
