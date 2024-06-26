class PostsController < ApplicationController

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to post_path(@post.id)
    else
      render :new
    end
  end

  def index
    @posts = Post.all
    @post = Post.new
    @user = current_user
    @post_user = @post.user
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.user
  end

  def edit
    post = Post.find(params[:id])
    unless post.user.id == current_user.id
      redirect_to "/posts"
    end

    @post = Post.find(params[:id])
  end

  def update
    post = Post.find(params[:id])
    unless post.user.id == current_user.id
      redirect_to "/posts"
    end

    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post.id)
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end



  private

  def post_params
    params.require(:post).permit(:pref, :facility_name, :title, :body)
  end

end
