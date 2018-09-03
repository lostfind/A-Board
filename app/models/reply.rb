class Reply < ApplicationRecord
  belongs_to :post
  def self.reply_list(post_id)
    @replies = Reply.where("post_id = ?", post_id)

    return @replies
  end
end
