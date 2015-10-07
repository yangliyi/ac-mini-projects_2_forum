class CommentsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_post, :set_comment
  before_action :set_comment, only: [:destroy]
  def create
    @comment = @post.comments.create(comment_params)
    @comment.user = current_user
    @post.last_comment = Time.now

    if @comment.save
      @post.save
      redirect_to post_path(@post)
    end
  end

  def destroy
    if current_user.admin? || current_user = @comment.user
      @comment.destroy
      respond_to do |format|
        format.html {
          redirect_to post_path(@post)
        }
        format.js
      end
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:commenter, :comment, :user_id)
  end
end
