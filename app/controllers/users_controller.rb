class UsersController < ApplicationController

  def my_friends
    @friends = current_user.friends
  end

  def my_portfolio
    @tracked_stocks = current_user.stocks
  end
end
