class ForumsController < ApplicationController
  def index
    @forums = Forum.main_list(params[:filter]).page(params[:page]).per(params[:per_page])
  end

  def show
    @current_forum = Forum.find_by_forum_id(params[:id])
    # @parent_forum = Forum.find_by_forum_id(@current_forum.parent_forum_id)
    # @forums = Forum.sub_list(params[:id]).page(params[:page]).per(params[:per_page])
    @posts = Post.new.forum_posts(params[:id], params[:filter]).page(params[:page]).per(params[:per_page])

    respond_to do |format|
      format.html
    end
  end
end
