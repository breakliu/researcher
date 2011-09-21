class User < ActiveRecord::Base
    authenticates_with_sorcery!

    attr_accessible :username, :password, :password_confirmation

    validates_confirmation_of :password
    validates_presence_of :password, :on => :create#, :message => I18n.t('test')
    validates_presence_of :username#, :message => 'dsfasdfasd'
    validates_uniqueness_of :username
end
