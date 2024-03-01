class UsersController < ApplicationController
  def new
  end

  def create
    existing_user_by_email = User.find_by("email" => params["email"])
    if existing_user_by_email
    flash["notice"] = "This email already exists in our database."
    redirect_to "/users/new"
  else
    @user = User.new
    @user["username"] = params["username"]
    @user["email"] = params["email"]
    @user["password"] = BCrypt::Password.create(params["password"])
    if @user.save
    redirect_to "/login"
    else
      flash["notice"] = "There was an issue creating your account. Please try again later."
      redirect_to "/users/new"
  end
end
end
end
