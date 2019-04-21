module ApplicationHelper
  def random_tweet
    user_id = User.where(bot: true).sample.id
    message = Faker::TvShows::TwinPeaks.quote
    Tweet.create!(message: message, user_id: user_id)
  end

  def profile_pic(user)
    if user.autopic != nil
      user.autopic
    elsif user.avatar.url != nil
      user.avatar.url
    else
      'default.png'
    end
  end

  def who_to_follow
    pick_three = (User.pluck(:id) - current_user.following).sample(3)
    User.where(id: pick_three)
  end
end
