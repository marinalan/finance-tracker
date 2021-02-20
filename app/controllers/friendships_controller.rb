class FriendshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    friend = User.find(params[:friend])
    # @friendship = Friendship.create(user: current_user, friend: friend)
    current_user.friendships.build(friend_id: friend.id)
    if current_user.save
      flash[:notice] = "Following friend #{friend.full_name || friend.email}"
    else
      flash[:alert] = "There was something wrong with the tracking request"
    end
    redirect_to my_friends_path

  end

  def destroy
    friendship = current_user.friendships.where(friend_id: params[:id]).first
    friendship.destroy if friendship
    flash[:notice] = "Stopped following"
    redirect_to my_friends_path
  end
end