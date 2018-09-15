class RepliesController < ApplicationController
  before_action :set_reply, only: [:show, :edit, :update, :destroy]

  def create
    @reply = Reply.new(reply_params)
    @reply.encryption
    if @reply.save
      redirect_to post_path(id: @reply.post_id), notice: 'Reply Posted!'
    else
      redirect_to post_path(id: @reply.post_id)
    end
  end

  def show

  end

  def edit
  end

  def update
    if @reply.valid_password?(params[:reply][:password])
      if @reply.update(update_params)
        redirect_to post_path(@reply.post_id), notice: 'コメントが編集されました。'
      end
    else
      flash[:error] = "passwords is not correct"
      render :action => 'edit'
    end
  end

  def destroy
    @reply.destroy
    redirect_to post_path(@reply.post_id)
  end

  def quote
    @reply = Reply.new
    @quote = Reply.find(params[:id])
    @reply.quote_reply_id = params[:id]
    @reply.post_id = @quote.post_id
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
