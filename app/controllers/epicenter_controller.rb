class EpicenterController < ApplicationController
  before_action :authenticate_user!
  
  def tag_tweets
    @tag = Tag.find(params[:id])
  end

  def feed
    @tweet = Tweet.new
    @following_tweets = Tweet.where(user_id: current_user.following).order(created_at: :desc)
  end

  def show_user
    @user = User.find(params[:id])
  end

  def all_users
    @users = User.all
  end

  def now_following
    current_user.following.push(params[:id].to_i)
    current_user.save

    redirect_to show_user_path(id: params[:id])
  end

  def unfollow
    current_user.following.delete(params[:id].to_i)
    current_user.save

    redirect_to show_user_path(id: params[:id])
  end

  def following
    @user = User.find(params[:id])
    @users = User.where(id: @user.following)
  end

  def followers
    @user = User.find(params[:id])
    @users = []

    User.all.each do |user|
      if user.following.include?(@user.id)
        @users.push(user)
      end
    end
  end
end
