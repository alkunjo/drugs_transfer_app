class NotificationBroadcastJob < ApplicationJob
  include NotificationsHelper
  queue_as :default

  def perform(notification)
    # partial = render_notification(notification)
    logger.debug "broadcasting notifikasi"
    ActionCable.server.broadcast 'notification_channel', notification: "ada notifikasi baru nih", recipients: [notification.recipient_id, 1], counter: counter
  end

  private

  # def render_counter(counter)
  #   ApplicationController.renderer.render(partial: 'notifications/counter', locals: { counter: counter })
  # end

  def render_notification(notification)
    # notif = ApplicationController.renderer.render(partial: 'notifications/notification', locals: { notification: notification })
    notif = NotificationsController.renderer.render(partial: 'notifications/notification', locals: { notification: notification })
    # return notif
  end
end
