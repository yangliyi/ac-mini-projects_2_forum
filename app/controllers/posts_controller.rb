class PostsController < ApplicationController

  before_action :authenticate_user!, except: [:index]

  def index


    @posts = Post.all

    if params[:category_id]

      @category = Category.find(params[:category_id])
      @posts = @category.posts

      if params[:order] == "topic"
        @posts = @posts.order('updated_at desc').page(params[:page]).per(5)
      elsif params[:order] == "replies"
        @posts = @posts.order("comments_count desc").page(params[:page]).per(5)
      else
        @posts = @posts.order('last_comment desc').page(params[:page]).per(5)
      end
    else
      if params[:order] == "topic"
        @posts = @posts.order('updated_at desc').page(params[:page]).per(5)
      elsif params[:order] == "replies"
        @posts = @posts.order("comments_count desc").page(params[:page]).per(5)
      else
        @posts = @posts.order('last_comment desc').page(params[:page]).per(5)
      end
    end
  end

  def new
    @post = Post.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      redirect_to post_path(@post)
    else
      render 'new'
    end

  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      redirect_to post_path(@post)
    else
      render 'edit'
    end

  end

  def show
    @post = Post.find(params[:id])
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    redirect_to posts_path
  end

  def about
    @posts = Post.all
    @comments = Comment.all
    @users = User.all
  end

  private

  def post_params
    params.require(:post).permit(:topic, :content, category_ids: [])
  end

end
