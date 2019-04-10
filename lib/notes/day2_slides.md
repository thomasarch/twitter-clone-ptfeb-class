# application.css

```
body {
  background-color: #e6ecf0;
}

.rounded-img {
  border-radius: 50%;
}

.profile-pic {
  border-radius: 50%;
  object-fit: cover;  
}
```

# new tweet form
```
<%= form_with(model: tweet, local: true) do |form| %>
  <% if tweet.errors.any? %>
    <div id="error_explanation">
      <h2><%= pluralize(tweet.errors.count, "error") %> prohibited this tweet from being saved:</h2>

      <ul>
      <% tweet.errors.full_messages.each do |message| %>
        <li><%= message %></li>
      <% end %>
      </ul>
    </div>
  <% end %>

  <%= image_tag profile_pic(current_user), size: 50, class: "rounded-img" %>

  <div class="field">
    <%= form.text_field :message, placeholder: "What's happening?", class: 'tweet-input' %>
  </div>

  <div class="field">
    <%= form.hidden_field :user_id, value: current_user.id %>
  </div>

  <div class="actions">
    <%= form.submit 'Tweet', class: 'btn btn-primary' %>
  </div>
<% end %>
```


# tweet card
```
<div class="tweet-container">
  <div class="tweet-content">
    <div class="tweet-heading">
      <%= image_tag profile_pic(tweet.user), size: 48, class: "profile-pic" %>
      <strong><%= link_to tweet.user.name, show_user_path(id: tweet.user.id) %></strong>
      <span class="check">✅</span> 
      <span class="text-muted">
        @<%= tweet.user.username %> 
        • <%= time_ago_in_words(tweet.created_at) %>
      </span>
    </div>
    <p><%= tweet.message.html_safe %></p>
  </div>
</div>
```


# tweets.css
```
.tweet-container {
  background-color: white;
  width: 580px;
  padding: 12px;
  margin-bottom: 1px;
}

.tweet-content {
  margin-left: 58px;
}

.tweet-container .profile-pic {
  position: absolute;
  margin-left: -58px;
  margin-top: -6px;
}

.check {
  position: relative;
  top: -3px;
  font-size: 8px;
}

.tweet-input {
  width: 380px;
  margin: 0 24px;
  padding: 6px 10px;
  border-radius: 8px;
  border: 2px solid #1da1f2;
}

textarea, select, input, button { outline: none; }
```

#epicenter.css
```
.tweet-box, .tweet-box form {
  display: flex;
  padding: 8px 0;
  justify-content: center;
  align-items: center;
  width: 580px;
  background-color: #E8F5FD;
}
```

# epicenter feed
```
<div class="tweet-box">
  <%= render 'tweets/form', tweet: @tweet %>
</div>

<div>
    <% @following_tweets.each do |tweet| %>
      <%= render 'layouts/tweet_card', tweet: tweet %>
    <% end %>
</div>
```



# get_tagged helper
def get_tagged(tweet)
  new_message = tweet.message.split.map do |word|
    if word[0] == '#'
      tag = if Tag.pluck(:phrase).include?(word.downcase)
        Tag.find_by(phrase: word.downcase)
      else
        Tag.create(phrase: word.downcase)
      end
      tweet_tag = TweetTag.create(tweet_id: tweet.id, tag_id: tag.id)
      "<a href='/tag_tweets?id=#{tag.id}'>#{word}</a>"
    else
      word
    end
  end
  tweet.update(message: new_message.join(' '))
  return tweet
end



# methods for link checking

```
def link_check
    if self.message.include?("http://") || self.message.include?("https://")
      truncated_message = self.message.split.map do |word|
        if word.include? "http"
          self.link.push(word)
          "#{word[0..20]...}"
        else
          word
        end
      end
      self.message = truncated_message.join(' ')
    end
  end

  def apply_link
    if self.message.include?("http://") || self.message.include?("https://")
      linked_message = self.message.split.map! do |word|
        if word.include? "http"
          "<a href='#{self.link.shift}' target='_blank'>#{word}</a>"
        else
          word
        end
      end
      self.message = linked_message.join(' ')
    end
  end
  ```



# add default profile pic to assets



# helper method for pics
```
def profile_pic(user)
  if user.autopic != nil
    user.autopic
  elsif user.avatar.url != nil
    user.avatar.url
  else
    'default.png'
  end
end
```