require "test_helper"

class FollowsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @other = users(:two)
    sign_in_as(@user)
  end

  test "should create follow" do
    assert_difference(-> { @user.reload.following_relationships.count }) do
      post follow_user_path(username: @other.username)
    end
    assert_redirected_to user_profile_path(@other.username)
  end

  test "should destroy follow" do
    @user.following_relationships.create!(following: @other)

    assert_difference(-> { @user.reload.following_relationships.count }, -1) do
      delete unfollow_user_path(username: @other.username)
    end
    assert_redirected_to user_profile_path(@other.username)
  end
end