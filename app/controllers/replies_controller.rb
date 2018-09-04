class RepliesController < ApplicationController
  before_action :set_reply, only: [:edit, :update, :destroy]

  def create
    @reply = Reply.new(reply_params)

    unless @reply.content.to_s.length == 0
      respond_to do |format|
        if @reply.save
          format.html { redirect_to post_path(id: @reply.post_id), notice: 'Reply Posted!' }
        else
          format.html { redirect_to post_path(id: @reply.post_id) }
        end
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @reply.update(reply_params)
        format.html { redirect_to post_path(@reply.post_id) }
      else
        format.html { render :edit }
      end
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
    params.require(:reply).permit(:post_id, :content, :user_id, :quote_reply_id, :lvl)
  end
end
