class ReplyLike < ApplicationRecord
  validates :reply_id, presence: true
  validates :user_ip, presence: true

  belongs_to :reply
end
