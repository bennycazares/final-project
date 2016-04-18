class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def index
  @users = User.all
  @hash = Gmaps4rails.build_markers(@users) do |user, marker|
    marker.lat user.latitude
    marker.lng user.longitude
    marker.title user.title
  end

  def create
    @user = User.new params.require(:user).permit(:email, :password, :password_confirmation)
    if @user.save
      # sign in
      session[:user_id] = @user.id
      # redirect
      redirect_to root_path, notice: "Thanks for signing up!"
    else
      render :new
    end
  end
end

end
