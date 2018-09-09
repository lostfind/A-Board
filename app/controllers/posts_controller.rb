class PostsController < ApplicationController
  before_action :set_post, only: [:edit, :show, :update, :destroy]

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
        format.html { redirect_to forum_path(id: @post.forum_id), notice: "スレッド作成完了"}
      else
        format.html { render :new }
      end
    end
  end

  def show
    @current_forum = Forum.find_by_forum_id(@post.forum_id)
    @parent_forum = Forum.find_by_forum_id(@current_forum.parent_forum_id)
    @replies = Reply.reply_list(@post.post_id)
    @reply = Reply.new
    @reply.post_id = @post.post_id
  end

  def edit
  end

  def update
    if @post.valid_password?(post_params[:password])
      if @post.update(update_params)
        redirect_to post_path(@post.post_id), notice: "スレッドが更新できました。"
      end
    else
      flash.now[:error] = "passwords is not correct"
      render :edit, post: @post
    end
  end

  def destroy
    if @post.destroy
      redirect_to forum_path(@post.forum_id), notice: "スレッドが削除されました。"
    else
      render :show
    end
  end

  private
  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:forum_id, :title, :content, :post_user_id, :password, :close_dttm)
  end

  def update_params
    params.require(:post).permit(:title, :content, :post_user_id, :close_dttm)
  end
end
