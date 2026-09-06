class PostsController < ApplicationController
  def index
    @posts = Post.order(created_at: :desc)
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = Current.user

    if @post.save
      redirect_to home_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @post = Post.find(params[:id])
    authorize_post
  end

  def update
    @post = Post.find(params[:id])
    authorize_post

    if @post.update(post_params)
      redirect_to @post
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post = Post.find(params[:id])
    authorize_post

    @post.destroy

    redirect_to home_path
  end

  def following
    @posts = Post
      .where(user: Current.user.following)
      .order(created_at: :desc)

    render :index
  end

  private

  def post_params
    params.expect(post: [:content])
  end

  def authorize_post
    redirect_to home_path unless @post.user == Current.user
  end
end