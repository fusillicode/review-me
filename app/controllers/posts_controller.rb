class PostsController < ApplicationController
  def index
    @post = Post.new
    @posts = Post.order('created_at DESC').page(params[:page]).per(4)

    respond_to do |format|
      format.html
      format.json { render json: @products }
      format.js
    end
  end

  def new
    @post = Post.new
  end

  def edit
    @post = post
  end

  def create
    post = Post.new(post_params)
    if post.save
      flash[:success] = "Post Created!"
      redirect_to posts_path
    else
      flash[:error] = "An error ocurred!"
      render :new
    end
  end

  def update
    if post.update(post_params)
      flash[:success] = "Post Updated!"
      redirect_to post
    else
      flash[:error] = "An error ocurred, Post not updated!"
      render 'edit'
    end
  end

  def show
    @post = post
    @comment = Comment.new
  end

  def destroy
    post.destroy
    redirect_to posts_path
  end

  private

  def post
    Post.find params[:id]
  end

  def post_params
    params.require(:post).permit(:body, :title, :user_id, comments_attributes: [:id, :body, :user_id])
  end
end
