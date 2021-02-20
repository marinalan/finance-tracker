class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:my_friends, :my_portfolio, :show, :search]

  def my_friends
    @friends = current_user.friends
  end

  def my_portfolio
    @user = current_user
    @tracked_stocks = current_user.stocks
  end

  def show
    @user = User.find(params[:id])
    @tracked_stocks = @user.stocks
  end

  def search
    # return render json: params[:friend]
    if params[:friend].present?
      @friends = User.search(params[:friend])
      @friends = current_user.except(@friends)
      if @friends
        respond_to do |format|
          format.js { render partial: 'users/friend_result' }
        end
      else
        respond_to do |format|
          flash.now[:alert] = "Couldn't find user"  
          format.js { render partial: 'users/friend_result' }
        end
      end
    else
      respond_to do |format|
        flash.now[:alert] = "Please enter a friend name or email to search"  
        format.js { render partial: 'users/friend_result' }
      end
    end
  end
end
