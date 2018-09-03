class Forum < ApplicationRecord
  has_many :posts
  def self.main_list
    forums = Forum.joins(
      "LEFT OUTER JOIN (SELECT COUNT(*) AS count_all, `posts`.`forum_id` AS posts_forum_id FROM `posts` GROUP BY `posts`.`forum_id`) posts
      ON forums.forum_id = posts.posts_forum_id")
                 .select('forums.*, posts.count_all')
                 .where("parent_forum_id IS NULL").order("forum_id")
    return forums
  end

  def self.sub_list(id)
    forums = Forum.joins(
        "LEFT OUTER JOIN (SELECT COUNT(*) AS count_all, `posts`.`forum_id` AS posts_forum_id FROM `posts` GROUP BY `posts`.`forum_id`) posts
      ON forums.forum_id = posts.posts_forum_id")
                 .select('forums.*, posts.count_all')
                 .where("parent_forum_id = ?", id).order("forum_id")
    return forums
  end
end
