# encoding: utf-8
class SessionsController < ApplicationController
  def new
  end

  def create
    user = login(params[:username], params[:password], params[:remember_me])
    if user
      #session[:user_popedom] = user.popedom
      #logger.info session.to_xml
      redirect_back_or_to root_url, :notice => "登录成功!"
    else
      flash.now.alert = "用户名或密码错误"
      render :new
    end
  end

  def destroy
    logout
    redirect_to root_url, :notice => "退出成功！"
  end
end
