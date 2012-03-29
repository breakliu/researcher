class AddSomeToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :mid_research, :text

    add_column :posts, :final_result, :text

    add_column :posts, :renewal, :text
    
    add_column :posts, :attach_data, :text

  end
end
