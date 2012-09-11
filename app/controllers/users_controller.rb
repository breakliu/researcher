# encoding: utf-8
class UsersController < ApplicationController
  before_filter :require_admin_login, :only => [:destroy, :index]

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to @user, :notice => "新建用户成功"
    else
      render :new
    end
  end

  def update
    @user = User.find(params[:id])    
    respond_to do | format |
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, :notice => "更新用户成功" }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def index
    @users = User.all
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :ok }
    end
  end

  def require_admin_login
    popedom = User.find(session[:user_id]).popedom
    if popedom != 1
      redirect_to root_url
    end
  end

end
