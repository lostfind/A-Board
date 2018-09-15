class Reply < ApplicationRecord
  paginates_per 10
  validates :content, presence: true
  belongs_to :post
  def self.reply_list(post_id)
    @replies = Reply.where("replies.post_id = ?", post_id)
                   .joins("LEFT JOIN replies AS quote ON replies.quote_reply_id = quote.reply_id")
                   .select("replies.*, quote.content as quote_content")

    return @replies
  end

  def valid_password?(password)
    # if Digest::MD5.hexdigest(password) == self.password
    if Digest::SHA256.hexdigest(password) == self.password
      return true
    else
      return false
    end
  end

  def encryption
    self.password = Digest::SHA256.hexdigest(self.password)
  end
end
