class SearchController < ApplicationController
  def index
    unless params[:category] == 'thread'
      @forums = Forum.main_list(params[:filter])
    end

    unless params[:category] == 'forums'
      @posts = Post.search_posts(params[:filter])
    end

  end
end
