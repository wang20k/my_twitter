class EpicenterController < ApplicationController
  def feed
  	@following_tweets = []
    if user_signed_in?
      Tweet.all.each do |tweet|
        if current_user.following.include?(tweet.user_id) 
          current_user.id == tweet.user_id
          @following_tweets.push(tweet)
        end
      end
    else
      redirect_to new_session_path(resource_name)
    end
    
  end

  def show_user
  	@user = User.find(params[:id])
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
end
