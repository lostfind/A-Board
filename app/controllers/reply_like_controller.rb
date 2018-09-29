class ReplyLikeController < ApplicationController
  def create
    @like = ReplyLike.new(reply_id: params[:id], user_ip: request.remote_ip)
    @like.save
    redirect_to post_path(@like.reply.post_id)
  end

  def destroy
    @like = ReplyLike.find_by(reply_id: params[:id], user_ip: request.remote_ip)
    ReplyLike.delete(reply_id: params[:id], user_ip: request.remote_ip)
    redirect_to post_path(@like.reply.post_id)
  end
end
