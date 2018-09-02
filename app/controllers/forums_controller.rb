class ForumsController < ApplicationController
  def index
    @forums = Forum.mainList
  end

  def show
    @parentForum = Forum.find_by_forum_id(params[:id])
    @forums = Forum.subList(params[:id])
    @haveSub = @forums.length
  end
end
