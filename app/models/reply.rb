class Reply < ApplicationRecord
  paginates_per 10
  validates :content, presence: true
  belongs_to :post
  has_many :quotes, class_name: "Reply", foreign_key: "reply_id"
  belongs_to :quote, class_name: "Reply", foreign_key: "quote_reply_id"
  has_many :reply_likes, dependent: :delete_all, foreign_key: "reply_id"

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

  def has_quote?(reply_id)
    if Reply.where("quote_reply_id = ?", reply_id).length > 0
      return true
    else
      return false
    end
  end
end
