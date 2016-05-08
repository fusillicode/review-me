class Api::V1::UserSerializer < Api::V1::BaseSerializer
  attributes :id, :email, :first_name,  :last_name, :role, :created_at, :updated_at

  has_many :posts
  has_many :comments
end
