class ForumsController < ApplicationController
  def index
    order = 'count_all DESC' if params[:order] === 'cnt_desc'
    order = 'write_dttm DESC' if params[:order] === 'date_desc'

    @forums = Forum.main_list(params[:filter], order).page(params[:page]).per(params[:per_page])
  end

  def show
    order = 'write_dttm DESC' if params[:order] === 'tdate_desc'
    order = 'r_cnt DESC' if params[:order] === 'cnt_desc'
    order = 'recent_dttm DESC' if params[:order] === 'cdate_desc'
    order = 'like_cnt DESC' if params[:order] === 'like_desc'

    @current_forum = Forum.find_by_forum_id(params[:id])
    # @parent_forum = Forum.find_by_forum_id(@current_forum.parent_forum_id)
    # @forums = Forum.sub_list(params[:id]).page(params[:page]).per(params[:per_page])
    @posts = Post.new.forum_posts(params[:id], params[:filter], order).page(params[:page]).per(params[:per_page])

    respond_to do |format|
      format.html
    end
  end
end
