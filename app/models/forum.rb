class Forum < ApplicationRecord
  def self.mainList
    forums = Forum.all.where("parent_forum_id IS NULL")
    return forums
  end

  def self.subList(id)
    forums = Forum.all.where("parent_forum_id = ?", id)
    return forums
  end

  def subListCount
    return self.subList(self).count
  end
end
