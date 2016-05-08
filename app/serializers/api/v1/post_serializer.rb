class Api::V1::PostSerializer < Api::V1::BaseSerializer
  attributes :id, :body, :title, :created_at, :updated_at

  has_one :user
  has_many :comments
end

