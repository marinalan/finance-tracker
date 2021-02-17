class FriendsController < ApplicationController
  def destroy
    friend = User.find(params[:id])
    friendship = Friendship.where(user_id: current_user.id, friend_id: friend.id).first
    friendship.destroy if friendship
    flash[:notice] = "#{friend.email} was successfully removed from portfolio"
    redirect_to my_friends_path
  end
end