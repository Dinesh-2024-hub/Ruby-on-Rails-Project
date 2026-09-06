class UsersController < ApplicationController
  allow_unauthenticated_access only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to new_session_path,
                  notice: "Account created successfully. Please log in."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @user = User.find_by!(username: params[:username])
    @posts = @user.posts.order(created_at: :desc)
  end

  private

  def user_params
    params.expect(
      user: [:email_address, :password, :password_confirmation, :username, :display_name]
    )
  end
end