class AddPartnerIdsToPost < ActiveRecord::Migration
  def change
    add_column :posts, :partner_ids, :text, :default => ""
  end


  def down
    remove_column :posts, :partner_ids  
  end
end
