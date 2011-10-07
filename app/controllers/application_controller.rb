class ApplicationController < ActionController::Base
  protect_from_forgery

  FLAG_CREATOR = 1
  FLAG_PARTNER = 2

  private
    def not_authenticated
      redirect_to login_url, :alert => I18n.t('first_login')
    end

end
