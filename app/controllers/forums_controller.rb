class ForumsController < ApplicationController
  def index
    @forums = Forum.main_list
  end

  def show
    @current_forum = Forum.find_by_forum_id(params[:id])
    @parent_forum = Forum.find_by_forum_id(@current_forum.parent_forum_id)
    @forums = Forum.sub_list(params[:id])
    @posts = Post.forum_posts(params[:id])

    respond_to do |format|
      format.html
    end
  end
end
