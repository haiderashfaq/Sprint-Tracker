class Comment < ApplicationRecord

  belongs_to :commentable, polymorphic: true
  belongs_to :company
  belongs_to :commenter, class_name: 'User'
  validates :description, presence: true
end
