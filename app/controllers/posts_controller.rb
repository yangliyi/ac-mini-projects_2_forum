class PostsController < ApplicationController

  before_action :authenticate_user!, except: [:index]
  before_action :set_post, :only => [:edit, :update, :destroy]

  def index
    @posts = Post.all

    if params[:category_id]

      @category = Category.find(params[:category_id])
      @posts = @category.posts

      if params[:order] == "created_at"
        @posts = @posts.order('created_at desc').page(params[:page]).per(10)
      elsif params[:order] == "replies"
        @posts = @posts.order("comments_count desc").page(params[:page]).per(10)
      else
        @posts = @posts.order('last_comment desc').page(params[:page]).per(10)
      end
    else
      if params[:order] == "created_at"
        @posts = @posts.order('created_at desc').page(params[:page]).per(10)
      elsif params[:order] == "replies"
        @posts = @posts.order("comments_count desc").page(params[:page]).per(10)
      else
        @posts = @posts.order('last_comment desc').page(params[:page]).per(10)
      end
    end
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user

    if @post.save
      flash[:notice] = "文章新增成功！"
      redirect_to post_path(@post)
    else
      render 'new'
    end

  end

  def update
    if @post.update(post_params)
      flash[:notice] = "文章修改成功！"
      redirect_to post_path(@post)
    else
      render 'edit'
    end

  end

  def show
    @post = Post.find(params[:id])
  end

  def destroy
    if @post.destroy
      flash[:notice] = "文章刪除成功！"

      redirect_to posts_path
    end
  end

  def about
    @posts = Post.all
    @comments = Comment.all
    @users = User.all
  end

  private

  def set_post
    if current_user.admin?
      @post = Post.find(params[:id])
    else
      @post = current_user.posts.find( params[:id] )
    end
  end

  def post_params
    params.require(:post).permit(:topic, :content, category_ids: [])
  end

end
