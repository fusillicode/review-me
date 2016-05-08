class Post < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  accepts_nested_attributes_for :comments

  belongs_to :user

  validates :title, presence: true
  validates :body, presence: true
end
