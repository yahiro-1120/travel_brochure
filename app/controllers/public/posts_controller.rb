class Public::PostsController < ApplicationController

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      address_list = params[:post][:address].split(',')
      address_list.each do |address|
        map = Map.new
        map.address = address
        map.post_id = @post.id
        map.save
      end
      redirect_to post_path(@post.id)
    else
      render :new
    end
  end

  def index
    @posts = Post.all
    @posts = Post.all.order(created_at: :desc)
    @post = Post.new
    @user = current_user
    @post_user = @post.user
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.user
    @post_comment = PostComment.new
    @post_comments = @post.post_comments
    @locations = @post.maps do |map| { address: map.address, latitude: map.latitude, longitude: map.longitude } end
  end

  def edit
    post = Post.find(params[:id])
    unless post.user.id == current_user.id
      redirect_to "/posts"
    end

    @post = Post.find(params[:id])
    @maps = Map.where(post_id: params[:id])
    @address = @maps.pluck(:address)
    @address_txt = @address.join(',')
  end

  def update
    post = Post.find(params[:id])
    unless post.user.id == current_user.id
      redirect_to "/posts"
    end

    @post = Post.find(params[:id])
    if @post.update(post_params)
      Map.where(post_id: @post.id).destroy_all

      address_list = params[:post][:address].split(',')
      address_list.each do |address|
        map = Map.new
        map.address = address
        map.post_id = @post.id
        map.save
      end
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
    params.require(:post).permit(:pref, :facility_name, :title, :body,)
  end

end
