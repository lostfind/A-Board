class ReplyLikeController < ApplicationController
  def like
    @like = ReplyLike.find_by(reply_id: params[:id], user_ip: request.remote_ip)
    if @like.nil?
      @like = ReplyLike.new(reply_id: params[:id], user_ip: request.remote_ip)
      @like.save
      @action = "like"
    else
      ReplyLike.delete(reply_id: params[:id], user_ip: request.remote_ip)
      @action = "unlike"
    end
    render json: {like_action: @action}
    # redirect_to post_path(@like.reply.post_id)
  end
end
