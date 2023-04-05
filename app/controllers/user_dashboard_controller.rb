class User::DashboardController < ApplicationController
  def index
    @user = @current_user
  end
end
