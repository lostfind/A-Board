class PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    respond_to do |format|
      if @post.save
        format.html { redirect_to forum_path(id: @post.forum_id), notice: 'Thread Posted!'}
      else
        format.html { render :new }
      end
    end
  end

  def show
    @post = Post.find_by_post_id(params[:id])
    @current_forum = Forum.find_by_forum_id(@post.forum_id)
    @parent_forum = Forum.find_by_forum_id(@current_forum.parent_forum_id)
    @replies = Reply.reply_list(@post.post_id)
    @reply = Reply.new
  end

  private
  def post_params
    params.require(:post).permit(:forum_id, :title, :content, :post_user_id, :close_dttm)
  end
end
