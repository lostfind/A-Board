class Post < ApplicationRecord
  paginates_per 30
  validates :title, presence: true
  validates :content, presence: true
  belongs_to :forum
  has_many :replies

  def forum_posts(forum_id)
    # @posts = Post.where("forum_id = ?", forum_id)
    @posts = Post.find_by_sql ["SELECT
      p.*
      , IFNULL(r.r_cnt, 0) AS r_cnt
      , IFNULL(r.recent_dttm, p.write_dttm) AS recent_dttm
      FROM posts p
      LEFT JOIN (
        SELECT
        post_id
        , COUNT(*) AS r_cnt
        , MAX(r.write_dttm) AS recent_dttm
        FROM replies r
        GROUP BY post_id
      ) r
      ON p.post_id = r.post_id
      WHERE p.forum_id = ?", forum_id]

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
