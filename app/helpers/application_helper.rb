module ApplicationHelper
  def random_tweet
    user_id = User.where(bot: true).sample.id
    message = Faker::TvShows::RickAndMorty.quote
    Tweet.create!(message: message, user_id: user_id)
  end
end
