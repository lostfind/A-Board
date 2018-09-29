class Post < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  belongs_to :forum
  has_many :replies
  has_many :post_likes, dependent: :delete_all, foreign_key: "post_id"

  def forum_posts(forum_id, filter, order = nil)
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
        .select("posts.*, IFNULL(replies.r_cnt, 0) AS r_cnt, IFNULL(replies.recent_dttm, posts.write_dttm) AS recent_dttm
                , CASE WHEN posts.close_dttm < CURRENT_DATE THEN true ELSE false END AS closed")
        .order("post_id").reorder(order)
    return @posts
  end

  def self.search_posts(filter)
    @posts = Post.where("posts.title like ?", "%#{filter}%")
        .joins("LEFT JOIN (
                SELECT
                post_id
                , COUNT(*) AS r_cnt
                , MAX(r.write_dttm) AS recent_dttm
                FROM replies r
                GROUP BY post_id
              ) replies
              ON posts.post_id = replies.post_id")
        .select("posts.*, IFNULL(replies.r_cnt, 0) AS r_cnt, IFNULL(replies.recent_dttm, posts.write_dttm) AS recent_dttm
                , CASE WHEN posts.close_dttm < CURRENT_DATE THEN true ELSE false END AS closed")
    return @posts
  end

  def valid_password?(password)
    if Digest::SHA256.hexdigest(password) == self.password
      return true
    else
      return false
    end
  end

  def encryption
    self.password = Digest::SHA256.hexdigest(self.password)
  end

  def has_comment?(post_id)
    if Reply.where("post_id = ?", post_id).length > 0
      return true
    else
      return false
    end
  end

  def is_closed?
    if self.close_dttm.nil? || self.close_dttm >= Date.today
      return false
    else
      return true
    end
  end
end
