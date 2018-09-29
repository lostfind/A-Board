class PostLikeController < ApplicationController
  def create
    @like = PostLike.new(post_id: params[:id], user_ip: request.remote_ip)
    @like.save
    redirect_to post_path(params[:id])
  end

  def destroy
    PostLike.delete(post_id: params[:id], user_ip: request.remote_ip)
    redirect_to post_path(params[:id])
  end
end
