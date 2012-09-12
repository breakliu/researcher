class AddEvaluateResultToPost < ActiveRecord::Migration
  def change
    add_column :posts, :evaluate_result, :text

  end
end
