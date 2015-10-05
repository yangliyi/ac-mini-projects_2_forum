class AddAttachmentAvatarToComments < ActiveRecord::Migration
  def up
    add_attachment :comments, :avatar
  end

  def down
    remove_attachment :comments, :avatar
  end
end
