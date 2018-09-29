class PostLike < ApplicationRecord
  validates :post_id, presence: true
  validates :user_ip, presence: true

  belongs_to :post

  def is_liked?

    return true
  end
end
