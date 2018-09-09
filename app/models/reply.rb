class Reply < ApplicationRecord
  validates :content, presence: true
  belongs_to :post
  def self.reply_list(post_id)
    @replies = Reply.where("post_id = ?", post_id)

    return @replies
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
