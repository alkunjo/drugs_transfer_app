class Notification < ApplicationRecord
  include NotificationsHelper
  after_create_commit { NotificationBroadcastJob.perform_later(self) }
	belongs_to :owner, class_name: 'User'
  belongs_to :recipient, class_name: 'Outlet'
end