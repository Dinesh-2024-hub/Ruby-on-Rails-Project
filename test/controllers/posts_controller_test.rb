require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    sign_in_as(@user)
    @post = @user.posts.create!(content: "Existing post")
  end

  test "should get index" do
    get home_path
    assert_response :success
  end

  test "should get new" do
    get new_post_path
    assert_response :success
  end

  test "should create post" do
    assert_difference("Post.count") do
      post posts_path, params: { post: { content: "Hello world" } }
    end
    assert_redirected_to home_path
  end

  test "should show post" do
    get post_path(@post)
    assert_response :success
  end

  test "should get edit" do
    get edit_post_path(@post)
    assert_response :success
  end

  test "should update post" do
    patch post_path(@post), params: { post: { content: "Updated" } }
    assert_redirected_to post_path(@post)
  end

  test "should destroy post" do
    assert_difference("Post.count", -1) do
      delete post_path(@post)
    end
    assert_redirected_to home_path
  end

  test "should get following" do
    get following_path
    assert_response :success
  end
end
