class LikesController < ApplicationController
  def create
    post = Post.find(params[:post_id])

    Current.user.likes.create!(post: post)

    redirect_to post_path(post)
  end

  def destroy
    post = Post.find(params[:post_id])

    like = Current.user.likes.find_by!(post: post)

    like.destroy

    redirect_to post_path(post)
  end
end
