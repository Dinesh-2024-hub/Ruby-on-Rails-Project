require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get new_user_path
    assert_response :success
  end

  test "should create user" do
    assert_difference("User.count") do
      post users_path, params: {
        user: {
          email_address: "new@example.com",
          password: "password123",
          password_confirmation: "password123",
          username: "newuser",
          display_name: "New User"
        }
      }
    end
    assert_redirected_to new_session_path
  end

  test "should show user" do
    sign_in_as(users(:one))
    get user_profile_path(users(:one).username)
    assert_response :success
  end
end