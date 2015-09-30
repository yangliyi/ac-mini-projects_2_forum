class PostsController < ApplicationController

  before_action :authenticate_user!, except: [:index]

  def index
    if params[:order] == "topic"
      @posts = Post.order('updated_at desc').page(params[:page]).per(5)
    elsif params[:order] == "replies"
      @posts = Post.order("comments_count desc").page(params[:page]).per(5)
    else
      @posts = Post.order('last_comment desc').page(params[:page]).per(5)
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
