class Post < ActiveRecord::Base
  has_many  :users_posts, :dependent => :delete_all
  has_many  :users, :through => :users_posts
  belongs_to :term

  validates_presence_of :title, :on => :create

  attr_accessible 	:title, :grade_or_class, :subject, :school, :research_time, :bk_purpose_importance, 
  					:content_question, :cond_outcome, :feature_creation, :process, :mid_research, :final_result, 
  					:renewal, :attach_data, :opinion1, :opinion2, :evaluate_result,
            :user_ids, :creator_id, :term_id

  #after_initialize :default_value

  #self.per_page = 15
  
  default_scope :order => 'created_at desc'

  # def default_value
  #   if self.title.nil?
  #     self.bk_purpose_importance = I18n.t('bk_purpose_importance_html')
  #   end
  # end
end
