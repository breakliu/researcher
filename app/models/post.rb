class Post < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :title

  after_initialize :default_value

  def default_value
    if self.title.nil?
      self.bk_purpose_importance = I18n.t('bk_purpose_importance_html')
    end
  end
end
