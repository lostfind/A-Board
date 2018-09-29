class PostLike < ApplicationRecord
  validates :post_id, presence: true
  validates :user_ip, presence: true

  belongs_to :post
end
