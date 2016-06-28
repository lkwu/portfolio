class Post < ActiveRecord::Base

  extend FriendlyId
  friendly_id :title, use: :slugged

  def prev
    Post.where(["id > ?", id ]).first
  end

  def next
    Post.where(["id < ?", id]).last
  end

end
