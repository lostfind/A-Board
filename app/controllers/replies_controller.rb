class RepliesController < ApplicationController
  def create
    @reply = Reply.new(reply_params)
    unless @reply.content.to_s.length == 0
      respond_to do |format|
        if @reply.save
          format.html { redirect_to post_path(id: @reply.post_id), notice: 'Reply Posted!'}
        else
          format.html { render :new }
        end
      end
    end
  end

  private
  def reply_params
    params.require(:reply).permit(:post_id, :content, :user_id, :quote_reply_id, :lvl)
  end
end
