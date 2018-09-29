class PostLikeController < ApplicationController
  def like
    @like = PostLike.find_by(post_id: params[:id], user_ip: request.remote_ip)
    if @like.nil?
      @like = PostLike.new(post_id: params[:id], user_ip: request.remote_ip)
      @like.save
      @action = "like"
    else
      PostLike.delete(post_id: params[:id], user_ip: request.remote_ip)
      @action = "unlike"
    end
    render json: {like_action: @action}
    # redirect_to post_path(params[:id])
  end
end
