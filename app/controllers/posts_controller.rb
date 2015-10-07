class PostsController < ApplicationController

  before_action :authenticate_user!, except: [:index]
  before_action :set_post, :only => [:edit, :update, :destroy]

  def index

    @tags = Tag.order("taggings_count DESC").limit(5)

    if params[:category_id]
      @category = Category.find(params[:category_id])
      @posts = @category.posts
    else
      @posts = Post.all
    end

    if params[:tag_id]
      @tag = Tag.find(params[:tag_id])
      @posts = @tag.posts
    end

    unless current_user && current_user.admin?
      @posts = @posts.where(status: 'published')
    end

    if ["comments_count", "id", "last_comment"].include?( params[:order] )
      @posts = @posts.order("#{params[:order]} DESC")
    else
      @posts = @posts.order("id DESC")
    end

    @posts = @posts.page(params[:page]).per(10)
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
      if @post.published?
        redirect_to post_path(@post)
      else
        redirect_to profile_path(current_user.profile)
      end
    else
      render 'new'
    end

  end

  def update
    if params[:destroy_photo] == "1"
        @post.photo = nil
    end

    if @post.update(post_params)
      flash[:notice] = "文章修改成功！"
      if @post.published?
        redirect_to post_path(@post)
      else
        redirect_to profile_path(current_user.profile)
      end
    else
      render 'edit'
    end

  end

  def show
    if current_user.admin?
      @post = Post.find(params[:id])
    else
      @post = Post.where(status: "published").find(params[:id])
    end
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

  # Add and remove favorite posts
  # for current_user
  def favorite
    @post = Post.find(params[:id])

    if current_user.favorite_post?(@post)
      current_user.favorites.delete(@post)
      redirect_to :back
    else
      current_user.favorites << @post
      redirect_to :back
    end
  end

  # Add and remove liked posts
  # for current_user
  def like
    @post = Post.find(params[:id])

    if current_user.like_post?(@post)
      current_user.liked_posts.delete(@post)
      respond_to do |format|
        format.html {
          redirect_to :back
        }
        format.js
      end
    else
      current_user.liked_posts << @post
      respond_to do |format|
        format.html {
          redirect_to :back
        }
        format.js
      end
    end
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
    params.require(:post).permit(:topic, :content, :status, :post_id, :photo, :tag_list, :tag_id, category_ids: [])
  end

end
