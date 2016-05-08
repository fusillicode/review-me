class Api::V1::UsersController < Api::V1::BaseController
  before_filter :authenticate_user!, only: [:show, :update, :destroy]

  def index
    users = User.all.order(created_at: :asc)
    users = policy_scope(users)

    render(
      json: ActiveModel::ArraySerializer.new(
        users,
        each_serializer: Api::V1::UserSerializer,
        root: 'users',
      )
    )
  end

  def create
    user = User.new(user_params)
    return api_error(status: 422, errors: user.errors) unless user.valid?

    user.save!

    render(
      json: Api::V1::UserSerializer.new(user).to_json,
      status: 201,
      location: api_v1_user_path(user.id)
    )
  end

  def show
    user = User.find(params[:id])
    authorize user

    render(json: Api::V1::UserSerializer.new(user).to_json)
  end

  def update
    user = User.find(params[:id])
    authorize user

    if !user.update_attributes(user_params)
      return api_error(status: 422, errors: user.errors)
    end

    render(
      json: Api::V1::UserSerializer.new(user).to_json,
      status: 200,
      location: api_v1_user_path(user.id),
      serializer: Api::V1::UserSerializer
    )
  end

  def destroy
    user = User.find(params[:id])
    authorize user

    if !user.destroy
      return api_error(status: 500)
    end

    head status: 204
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end
