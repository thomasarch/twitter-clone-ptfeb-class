class AddRetweetToTweets < ActiveRecord::Migration[5.2]
  def change
    add_column :tweets, :retweet, :boolean
  end
end