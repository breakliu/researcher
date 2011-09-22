class AddManyToPost < ActiveRecord::Migration
  def change
    add_column :posts, :owner_id, :integer
    add_column :posts, :user_id, :integer
    add_column :posts, :grade_or_class, :string, :default => ''
    add_column :posts, :subject, :string, :default => ''
    add_column :posts, :school, :string, :default => ''
    add_column :posts, :research_time, :string, :default => ''
    add_column :posts, :bk_purpose_importance, :text, :default => ''
    add_column :posts, :content_question, :text, :default => ''
    add_column :posts, :cond_outcome, :text, :default => ''
    add_column :posts, :feature_creation, :text, :default => ''
    add_column :posts, :process, :text, :default => ''
    add_column :posts, :opinion1, :text, :default => ''
    add_column :posts, :opinion2, :text, :default => ''
  end

  def self.down
    remove_column :posts, :owner_id
    remove_column :posts, :user_id
    remove_column :posts, :grade_or_class
    remove_column :posts, :subject
    remove_column :posts, :school
    remove_column :posts, :research_time
    remove_column :posts, :bk_purpose_importance
    remove_column :posts, :content_question
    remove_column :posts, :cond_outcome
    remove_column :posts, :feature_creation
    remove_column :posts, :process
    remove_column :posts, :opinion1
    remove_column :posts, :opinion2
  end
end
