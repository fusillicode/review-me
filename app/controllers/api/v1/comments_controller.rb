class Api::V1::CommentsController < Api::V1::BaseController
  before_filter :authenticate_user!

  def index
    comments = Comment.where(user_id: params[:user_id])

    comments = policy_scope(comments)

    render(
      json: ActiveModel::ArraySerializer.new(comments,
        each_serializer: Api::V1::CommentSerializer,
        root: 'comments',
      )
    )
  end

  def show
    comment = Comment.find(params[:id])
    authorize comment

    render json: Api::V1::CommentSerializer.new(comment).to_json
  end

  def create
    comment = Comment.new(comment_params)
    return api_error(status: 422, errors: comment.errors) unless comment..valid?

    comment.save!

    render(
      json: Api::V1::CommentSerializer.new(comment).to_json,
      status: 201,
      location: api_v1_comment_path(comment.id),
      serializer: Api::V1::CommentSerializer
    )
  end

  def update
    comment = Comment.find(params[:id])

    authorize comment

    if !comment.update_attributes(comment_params)
      return api_error(status: 422, errors: comment.errors)
    end

    render(
      json: Api::V1::CommentSerializer.new(Comment).to_json,
      status: 200,
      location: api_v1_comment_path(comment.id),
      serializer: Api::V1::CommentSerializer
    )
  end

  def destroy
    comment = Comment.find(params[:id])

    authorize comment

    if !comment.destroy
      return api_error(status: 500)
    end

    head status: 204
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :user_id)
  end
end
