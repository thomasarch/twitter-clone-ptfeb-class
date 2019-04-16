module EpicenterHelper
  def get_users_followers(selected_user)
    count = 0
    User.all.each do |user|
      if user.following.include? selected_user.id
        count += 1
      end
    end
    count
  end
end
