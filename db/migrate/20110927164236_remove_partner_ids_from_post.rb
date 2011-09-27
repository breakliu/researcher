class RemovePartnerIdsFromPost < ActiveRecord::Migration
  def up
    remove_column :posts, :partner_ids
    remove_column :users_posts, :is_creator
    add_column :users_posts, :operate_post_flag, :integer, :default => 0
  end

  def down
    add_column :posts, :partner_ids, :text, :default => ""
    add_column :users_posts, :is_creator, :boolean, :default => false
  end
end
