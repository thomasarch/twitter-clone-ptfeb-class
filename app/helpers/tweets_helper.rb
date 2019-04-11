module TweetsHelper
  def get_tagged(tweet)
    new_message = tweet.message.split.map do |word|
      if word[0] == '#'
        tag = if Tag.pluck(:phrase).include?(word.downcase)
          Tag.find_by(phrase: word.downcase)
        else
          Tag.create(phrase: word.downcase)
        end
        TweetTag.create(tweet_id: tweet.id, tag_id: tag.id)
        "<a href='/tag_tweets?id=#{tag.id}'>#{word}</a>"
      else
        word
      end
    end
    tweet.update(message: new_message.join(' '))
    return tweet
  end
end




message = "hello this is a #tweet"

new_message = message.split.map do |word|
  if word[0] == '#'
     "<a href='/tag_tweets?id=1'>#{word}</a>"
   else
    word
  end
end

p new_message.join(' ')