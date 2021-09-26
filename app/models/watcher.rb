class Watcher < ApplicationRecord
	belongs_to :user
  belongs_to :issue
  belongs_to :company

  validates :user, uniqueness: { scope: :issue_id }
end
