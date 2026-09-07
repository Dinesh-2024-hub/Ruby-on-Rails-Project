class FollowsController < ApplicationController
  def create
    user = User.find_by!(username: params[:username])

    unless user == Current.user
      Current.user.following_relationships.create!(
        following: user
      )
    end

    redirect_to user_profile_path(user.username)
  end

  def destroy
    user = User.find_by!(username: params[:username])

    follow =
      Current.user.following_relationships.find_by(
        following: user
      )

    follow&.destroy

    redirect_to user_profile_path(user.username)
  end
end
