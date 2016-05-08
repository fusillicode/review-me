class Api::V1::CommentSerializer < Api::V1::BaseSerializer
  attributes :id, :body, :created_at, :updated_at

  has_one :user
  has_one :post
end

