class PostsController < ApplicationController

  before_action :find_post, :only => [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, :except => [:index, :show]

  def index
    @posts = Post.all.order('created_at DESC').paginate(page: params[:page], per_page: 5)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      redirect_to @post
    else
      render 'new', alert: "Unable to save the post"
    end
  end

  def show
    if request.path != post_path(@post)
      return redirect_to @post, status: :moved_permanently
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to @post
    else
      render 'edit'
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :slug)
  end

  def find_post
    @post = Post.friendly.find(params[:id])
  end

end
