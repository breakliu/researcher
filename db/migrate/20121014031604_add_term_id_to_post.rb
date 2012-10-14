class AddTermIdToPost < ActiveRecord::Migration
  def change
    add_column :posts, :term_id, :integer
  end
end
