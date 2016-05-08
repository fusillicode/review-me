class Api::V1::PostsController < Api::V1::BaseController
  before_filter :authenticate_user!

  def index
    posts = Post.where(user_id: params[:user_id])

    posts = policy_scope(posts)

    render(
      json: ActiveModel::ArraySerializer.new(posts,
        each_serializer: Api::V1::PostSerializer,
        root: 'posts',
      )
    )
  end

  def show
    post = Post.find(params[:id])
    authorize post

    render json: Api::V1::PostSerializer.new(post).to_json
  end

  def create
    post = Post.new(post_params)
    return api_error(status: 422, errors: post.errors) unless post.valid?

    post.save!

    render(
      json: Api::V1::PostSerializer.new(post).to_json,
      status: 201,
      location: api_v1_post_path(post.id),
      serializer: Api::V1::PostSerializer
    )
  end

  def update
    post = Post.find(params[:id])

    authorize post

    if !post.update_attributes(post_params)
      return api_error(status: 422, errors: post.errors)
    end

    render(
      json: Api::V1::PostSerializer.new(Post).to_json,
      status: 200,
      location: api_v1_post_path(post.id),
      serializer: Api::V1::PostSerializer
    )
  end

  def destroy
    post = Post.find(params[:id])

    authorize post

    if !post.destroy
      return api_error(status: 500)
    end

    head status: 204
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :user_id)
  end
end
