class RepliesController < ApplicationController
  before_action :set_reply, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token

  def create
    @reply = Reply.new(reply_params)
    @reply.encryption

    if @reply.user_id === ''
      @reply.user_id = 'Anonymous'
    end

    if @reply.save
      redirect_to post_path(id: @reply.post_id), notice: 'コメントを登録しました。'
    else
      redirect_to post_path(id: @reply.post_id), notice: 'コメント登録失敗しました。'
    end
  end

  def show

  end

  def edit
    if params[:reply].nil?
      redirect_to post_path(@reply.post_id)
    elsif @reply.valid_password?(params[:reply][:password])
      if is_closed?
        redirect_to post_path(@reply.post_id), alert: 'スレッドが締切です。'
      end
      @post = Post.find(@reply.post_id)
    else
      redirect_to post_path(@reply.post_id), alert: 'パスワードが一致しません。'
    end
  end

  def update
    if @reply.update(update_params)
      redirect_to post_path(@reply.post_id), notice: 'コメントが編集されました。'
    else
      flash[:alert] = 'エラーが発生しました。'
      render :action => 'edit'
    end
  end

  def destroy
    if params[:reply].nil?
      redirect_to post_path(@reply.post_id)
    elsif @reply.valid_password?(params[:reply][:password])
      if is_closed?
        redirect_to post_path(@reply.post_id), alert: 'スレッドが締切です。'
      else
        if @reply.has_quote?(@reply.reply_id)
          flash[:alert] = '引用されているコメントは削除できません。'
        else
          @reply.destroy
          flash[:notice] = 'コメントが削除されました。'
        end
        redirect_to post_path(@reply.post_id)
      end
    else
      redirect_to post_path(@reply.post_id), alert: 'パスワードが一致しません。'
    end
  end

  def quote
    @reply = Reply.new
    @quote = Reply.find(params[:id])
    @reply.quote_reply_id = params[:id]
    @reply.post_id = @quote.post_id

    if is_closed?
      redirect_to post_path(@reply.post_id), notice: 'スレッドが締切です。'
    end
  end

  private
  def set_reply
    if @reply.nil?
      @reply = Reply.find(params[:id])
    end
  end

  def reply_params
    params.require(:reply).permit(:post_id, :content, :user_id, :password, :quote_reply_id, :lvl)
  end

  def update_params
    params.require(:reply).permit(:content, :user_id)
  end

  def is_closed?
    return Post.find(@reply.post_id).is_closed?
  end
end
