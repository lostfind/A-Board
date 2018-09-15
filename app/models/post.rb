class Post < ApplicationRecord
  paginates_per 30
  validates :title, presence: true
  validates :content, presence: true
  belongs_to :forum
  has_many :replies

  def forum_posts(forum_id, filter)

    @posts = Post.where("posts.forum_id = ? AND posts.title like ?", forum_id, "%#{filter}%")
        .joins("LEFT JOIN (
                SELECT
                post_id
                , COUNT(*) AS r_cnt
                , MAX(r.write_dttm) AS recent_dttm
                FROM replies r
                GROUP BY post_id
              ) replies
              ON posts.post_id = replies.post_id")
        .select("posts.*, IFNULL(replies.r_cnt, 0) AS r_cnt, IFNULL(replies.recent_dttm, posts.write_dttm) AS recent_dttm")
    return @posts
  end

  def valid_password?(password)
    if Digest::MD5.hexdigest(password) == self.password
      return true
    else
      return false
    end
  end

  def encryption
    self.password = Digest::MD5.hexdigest(self.password)
  end
end
