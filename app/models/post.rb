class Post < ApplicationRecord
  belongs_to :forum
  has_many :replies
  def self.forum_posts(forum_id)
    @posts = Post.where("forum_id = ?", forum_id)
    return @posts
  end
end
