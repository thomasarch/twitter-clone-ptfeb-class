module EpicenterHelper
  def get_users_followers
    count = 0
    User.all.each do |user|
      if user.following.include? current_user.id
        count += 1
      end
    end
    count
  end
end
