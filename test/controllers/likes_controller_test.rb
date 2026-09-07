require "test_helper"

class LikesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    sign_in_as(@user)
    @post = users(:two).posts.create!(content: "Post to like")
  end

  test "should create like" do
    assert_difference("Like.count") do
      post post_likes_path(@post)
    end
    assert_redirected_to post_path(@post)
  end

  test "should destroy like" do
    like = @user.likes.create!(post: @post)

    assert_difference("Like.count", -1) do
      delete post_like_path(@post, like)
    end
    assert_redirected_to post_path(@post)
  end
end
