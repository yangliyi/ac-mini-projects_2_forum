module PostsHelper

  def can_edit_post?(post)
    current_user && ( current_user == post.user || current_user.admin? )
  end
end
