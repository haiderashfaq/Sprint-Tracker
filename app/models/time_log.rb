class TimeLog < ApplicationRecord
  sequenceid :issue, :time_logs
  belongs_to :issue
  belongs_to :assignee, class_name: 'User', optional: true
end
