class PostsController < ApplicationController
  before_action :set_post, only: [:edit, :show, :update, :destroy]
  skip_before_action :verify_authenticity_token

  def new
    @post = Post.new
    @current_forum = Forum.find_by_forum_id(params[:forum_id])
    @parent_forum = Forum.find_by_forum_id(@current_forum.parent_forum_id)
  end

  def create
    @post = Post.new(post_params)
    @post.encryption
    respond_to do |format|
      if @post.save
        format.html { redirect_to forum_path(id: @post.forum_id), notice: 'スレッド作成完了'}
      else
        format.html { render :new }
      end
    end
  end

  def show
    # @current_forum = Forum.find_by_forum_id(@post.forum_id)
    # @parent_forum = Forum.find_by_forum_id(@current_forum.parent_forum_id)
    @replies = @post.replies.page(params[:page]).per(params[:per_page])
    @reply = Reply.new(post_id: @post.post_id)
    @post_liked = true unless PostLike.find_by(post_id: @post.post_id, user_ip: request.remote_ip).nil?
  end

  def edit
    if params[:post].nil?
      redirect_to post_path(@post.post_id)
    elsif @post.valid_password?(params[:post][:password])
      if is_closed?
        redirect_to post_path(@post.post_id), alert: 'スレッドが締切です。'
      end
    else
      redirect_to post_path(@post.post_id), alert: 'パスワードが一致しません。'
    end
  end

  def update
    if @post.update(update_params)
      redirect_to post_path(@post.post_id), notice: 'スレッドを更新しました。'
    else
      flash[:alert] = 'エラーが発生しました。'
      render :edit, post: @post
    end
  end

  def destroy
    if params[:post].nil?
      redirect_to post_path(@post.post_id)
    elsif @post.valid_password?(params[:post][:password])
      if is_closed?
        redirect_to post_path(@post.post_id), alert: 'スレッドが締切です。'
      else
        if @post.has_comment?(@post.post_id)
          flash[:alert] = 'コメントがあるスレッドは削除できません。'
          redirect_to post_path(@post.post_id)
        else
          @post.destroy
          flash[:notice] = 'スレッドが削除されました。'
          redirect_to forum_path(@post.forum_id)
        end
      end
    else
      redirect_to post_path(@post.post_id), alert: 'パスワードが一致しません。'
    end
  end

  def post_like
    @post = Post.find(params[:id])
    @post.like

    redirect_to post_path(@post.post_id)
  end

  private
  def set_post
    @post = Post.find(params[:id])
    @closed = is_closed?
  end

  def post_params
    params.require(:post).permit(:forum_id, :title, :content, :post_user_id, :password, :close_dttm)
  end

  def update_params
    params.require(:post).permit(:title, :content, :post_user_id, :close_dttm)
  end

  def is_closed?
    if @post.close_dttm.nil? || @post.close_dttm > Date.today
      return false
    else
      return true
    end
  end
end
