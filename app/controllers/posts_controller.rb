# encoding: utf-8
class PostsController < ApplicationController
  before_filter :require_login, :only => [:new, :edit, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    if not params[:term_id].blank?
      @posts = Term.find(params[:term_id]).posts
    else
      @posts = Term.first.posts#paginate(:page => params[:page])
    end
    @creator = {}
    @partner = {}

    # 保存负责人与参与者的名单
    @posts.each do |post|
      creator = User.find(post.creator_id)
      if logged_in?
        @creator[post.id] = { :username => creator.username, :can_operate => (current_user.id == creator.id or current_user.popedom == 1) }
      else
        @creator[post.id] = { :username => creator.username, :can_operate => false }
      end

      p_name = []
      p_id = []
      post.users_posts.each do |partner|
        if partner.user.id != creator.id
          p_name << partner.user.username
          p_id << partner.user.id
        end
      end
      if logged_in?
        @partner[post.id] = { :username => p_name.join(', '), :can_operate => (p_id.include?(current_user.id) or current_user.popedom == 1) }
      else
        @partner[post.id] = { :username => p_name.join(', '), :can_operate => false }
      end
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])
    @creator = User.find(@post.creator_id)

    p_name = []
    @post.users_posts.each do |partner|
      if partner.user.id != @creator.id
        p_name << partner.user.username
      end
    end
    @partners = p_name.join(', ')

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    @post = Post.new
    @users = User.where('id NOT IN (?) AND popedom = 0', current_user.id)

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
    @users = User.where('id NOT IN (?) AND popedom = 0', @post.creator_id)
  end

  # POST /posts
  # POST /posts.json
  def create
    # 当前用户就是创建者
    params[:post][:creator_id] = current_user.id

    # 如果没有加入自己的id到关联表数组，手动加入
    if not params[:post][:user_ids].include?(params[:post][:creator_id])
      params[:post][:user_ids].insert(0, params[:post][:creator_id])
    end
    @post = Post.new(params[:post])

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: '新建课题成功' }
        format.json { render json: @post, status: :created, location: @post }
      else
        format.html { redirect_to :action => :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    @post = Post.find(params[:id])

    respond_to do |format|
      # 如果没有加入自己的id到关联表数组，手动加入
      #if not params[:post][:user_ids].include?(params[:post][:creator_id])
      #  params[:post][:user_ids].insert(0, params[:post][:creator_id])
      #end
      if @post.update_attributes(params[:post])
        format.html { redirect_to @post, notice: '更新课题成功' }
        format.json { head :ok }
      else
        format.html { redirect_to :action => :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :ok }
    end
  end
end
