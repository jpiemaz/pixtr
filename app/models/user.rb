class User < ActiveRecord::Base
  include Clearance::User

  has_many :galleries
  has_many :images, through: :galleries

  has_many :likes
  has_many :liked_images, through: :likes, source: :image

  has_many :group_memberships, foreign_key: :member_id
  has_many :groups, through: :group_memberships

  has_many :followed_user_relationships,
    foreign_key: :follower_id,
    class_name: "FollowingRelationship"

  has_many :followed_users,
    through: :followed_user_relationships

  has_many :follower_relationships,
    foreign_key: :followed_user_id,
    class_name: "FollowingRelationship"

  has_many :followers,
    through: :follower_relationships


  def follow(user)
    followed_users << user
  end

  def following?(user)
    followed_user_ids.include? user.id
  end

  def unfollow(user)
    followed_users.destroy(user)
  end

  def join(group)
    groups << group
  end

  def leave(group)
    groups.destroy(group)
  end

  def member?(group)
    group_ids.include? group.id
  end

  def like(image)
    liked_images << image
  end

  def liked?(image)
    liked_image_ids.include? image.id
  end

  def unlike(image)
    liked_images.destroy(image)
  end
end
