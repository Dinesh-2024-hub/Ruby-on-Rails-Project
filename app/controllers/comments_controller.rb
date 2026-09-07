class CommentsController < ApplicationController
  def create
    post = Post.find(params[:post_id])

    comment = post.comments.build(comment_params)
    comment.user = Current.user

    if comment.save
      redirect_to post_path(post)
    else
      redirect_to post_path(post),
                  alert: comment.errors.full_messages.to_sentence
    end
  end

  def destroy
    post = Post.find(params[:post_id])
    comment = post.comments.find(params[:id])

    if comment.user == Current.user
      comment.destroy
    end

    redirect_to post_path(post)
  end

  private

  def comment_params
    params.expect(comment: [ :content ])
  end
end
