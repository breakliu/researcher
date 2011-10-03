# encoding: utf-8
class PostsController < ApplicationController
  before_filter :require_login, :only => [:new, :edit, :destroy]
  #before_filter :partner_ids_to_text, :only => [:create, :update]
  include_kindeditor :only => [:new, :edit]
  
  FLAG_CREATOR = 1
  FLAG_PARTNER = 2

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
    @creator = {}
    @partner = {}

    # 保存负责人与参与者的名单
    @posts.each do |post|
      c_name = []
      p_name = []
      c_id = []
      p_id = []

      post.users_posts.where(:operate_post_flag=>1).each do |creator|
        c_name << creator.user.username
        c_id << creator.user.id
      end
      post.users_posts.where(:operate_post_flag=>2).each do |partner|
        p_name << partner.user.username
        p_id << partner.user.id
      end

      @creator[post.id] = {:creator => c_name.join(', '), :can_operate => c_id.include?(session[:user_id])}
      @partner[post.id] = {:partner => p_name.join(', '), :can_operate => p_id.include?(session[:user_id])}
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

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    @post = Post.new
    # 作为创建者的自身不放到参与者那里
    @users = User.find(:all, :conditions => ['id NOT IN (?)', [session[:user_id]]])
    @checkbox = {}

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
    # 作为创建者的自身不放到参与者那里
    @users = User.find(:all, :conditions => ['id NOT IN (?)', [session[:user_id]]])
    @checkbox = {}

    # 为选中的参与者标记
    ids = @post.user_ids
    # 不能包自身
    ids.delete(session[:user_id])
    ids.each do |id|
      @checkbox[id.to_i] = true
    end
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(params[:post])
    ret1 = false
    ret2 = false

    # 事业处理, 创建post同时要创建好对应的关联关系
    ActiveRecord::Base.transaction do
      ret1 = @post.save

      if ret1
        ret2 = create_users_posts(@post.id, params[:partner_ids])
        if not ret2
          raise ActiveRecord::Rollback
        end
      else
        raise ActiveRecord::Rollback
      end
    end

    respond_to do |format|
      if ret1 and ret2
        format.html { redirect_to @post, notice: '保存成功!' }
        format.json { render json: @post, status: :created, location: @post }
      else
        flash[:notice] = "保存失败，已回滚了数据库，请联系开发人员"
        format.html { redirect_to :action => :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    @post = Post.find(params[:id])
    ret = false

    ActiveRecord::Base.transaction do
      ret = update_partner_ids(@post.id, params[:partner_ids])
      if not ret
        raise ActiveRecord::Rollback
      end
    end

    respond_to do |format|
      if ret and @post.update_attributes(params[:post])
        format.html { redirect_to @post, notice: '更新成功' }
        format.json { head :ok }
      else
        flash[:notice] = "保存失败，已回滚了数据库，请联系开发人员"
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

  private
  def update_partner_ids(post_id, partner_ids)
    UsersPost.where(:post_id=>post_id, :operate_post_flag=>FLAG_PARTNER).delete_all
    if not partner_ids.nil?
      partner_ids.each do |id|
        partner = UsersPost.new(:user_id=>id, :post_id=>post_id, :operate_post_flag=>FLAG_PARTNER)
        if not partner.save
          return false
        end
      end
    end
    return true
  end

  #把用户和post关键起来
  #operate_post_flag: 创键者用1，参与者用2
  def create_users_posts(post_id, partner_ids)
    creator = UsersPost.new(:user_id=>session[:user_id], :post_id=>post_id, :operate_post_flag=>FLAG_CREATOR)
    if not creator.save
      return false
    end

    return update_partner_ids(post_id, partner_ids)
  end
end
