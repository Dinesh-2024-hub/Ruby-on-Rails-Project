require "test_helper"

class CommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    sign_in_as(@user)
    @post = @user.posts.create!(content: "Post with comments")
  end

  test "should create comment" do
    assert_difference("Comment.count") do
      post post_comments_path(@post), params: { comment: { content: "Nice post!" } }
    end
    assert_redirected_to post_path(@post)
  end

  test "should destroy comment" do
    comment = @post.comments.create!(content: "temp", user: @user)

    assert_difference("Comment.count", -1) do
      delete post_comment_path(@post, comment)
    end
    assert_redirected_to post_path(@post)
  end
end