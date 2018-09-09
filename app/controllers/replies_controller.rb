class RepliesController < ApplicationController
  before_action :set_reply, only: [:edit, :update, :destroy]

  def create
    @reply = Reply.new(reply_params)
    @reply.encryption
    if @reply.save
      redirect_to post_path(id: @reply.post_id), notice: 'Reply Posted!'
    else
      redirect_to post_path(id: @reply.post_id)
    end
  end

  def edit
  end

  def update
    if @reply.valid_password?(reply_params[:password])
      if @reply.update(reply_params)
        redirect_to post_path(@reply.post_id)
      end
    else
      flash.now[:error] = "passwords is not correct"
      render :edit
    end
  end

  def destroy
    respond_to do |format|
      @reply.destroy
      format.html { redirect_to post_path(@reply.post_id) }
    end
  end

  private
  def set_reply
    @reply = Reply.find(params[:id])
  end

  def reply_params
    params.require(:reply).permit(:post_id, :content, :user_id, :password, :quote_reply_id, :lvl)
  end

  def update_params
    params.require(:reply).permit(:content, :user_id)
  end
end
