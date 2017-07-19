require "pry"
class NotificationBroadcastJob < ApplicationJob
  include NotificationsHelper
  queue_as :default

  def perform(notification)
    binding.pry
    logger.debug "broadcasting notifikasi"
    ActionCable.server.broadcast 'notification_channel', notification: make_link(notification), recipients: [notification.recipient_id, 1], counter: render_counter(notification)
  end

  private

  def render_counter(notification)
    # set admin and count notif admin
    admin = User.joins(:role).where("roles.role_name = 'Super Admin'").first.id
    notifadmin = Notification.all.where(readStat_admin: nil).count()
    
    # set pengadaan and count notif pengadaan
    pengadaan = User.joins(:role).where(outlet_id: notification.recipient_id).where("roles.role_name = 'PIC Pengadaan'").first.id
    notifpengadaan = Notification.where(recipient_id: notification.recipient_id).where(readStat_receiver: nil).count()

    # set gudang and count notif gudang
    gudang = User.joins(:role).where(outlet_id: notification.recipient_id).where("roles.role_name = 'PIC Gudang'").first.id
    notifgudang = Notification.where(recipient_id: notification.recipient_id).where(readStat_receiver: nil).count()    

    # pimpinan
    pimpinan = User.joins(:role).where(outlet_id: notification.recipient_id).where("roles.role_name = 'Pimpinan Outlet'").first.id
    notifpimpinan = Notification.where(recipient_id: notification.recipient_id).where(readStat_manager: nil).count()

    a = [["#{admin}","#{notifadmin}"],["#{pengadaan}","#{notifpengadaan}"],["#{gudang}","#{notifgudang}"],["#{pimpinan}","#{notifpimpinan}"]]
    return a
  end

  def render_notification(notification)
    # include NotificationsHelper
    NotificationsController.renderer.render(partial: 'notifications/notification', locals: { notification: notification })
  end

  def notify(notification)
    owner = User.find_by(user_id: notification.owner_id)
    recipient = Outlet.find_by(outlet_id: notification.recipient_id)
    
    transaksi = Transaksi.find_by(transaksi_id: notification.transaksi_id)
    bpba = "Nomor BPBA: B#{transaksi.sender_id}#{transaksi.receiver_id}#{transaksi.asked_at.strftime('%d%m%Y')}"

    message = if notification.key_message == "asked"
      " meminta obat dengan <b>#{bpba}</b> kepada outlet "
    elsif notification.key_message == "dropped"
      " memberikan obat berdasarkan <b>#{bpba}</b> kepada outlet "
    elsif notification.key_message == "accepted"
      " menerima obat berdasarkan <b>#{bpba}</b> dari outlet "
    end
    complete_message = "<b> #{owner.user_fullname} </b>"+ message + "<b> #{recipient.outlet_name} </b>"
    return complete_message.html_safe
  end

  # generate link for notification lists
  def make_link(notification)
    complete_message = notify(notification)
    transaksi = Transaksi.find_by(transaksi_id: notification.transaksi_id)
    sign = ""
    style = 'font-size: 12px; color: #000'
    span = ""
    if notification.key_message == "asked"
      sign = "<i class='fa fa-arrow-circle-up fa-fw'></i>&nbsp;"
      span = "<span class='pull-right text-muted-small'>
                <em>#{transaksi.asked_at.strftime("%d %B %Y")}</em>
              </span>"
    elsif notification.key_message == "dropped"
      sign = "<i class='fa fa-arrow-circle-down fa-fw'></i>&nbsp;"
      span = "<span class='pull-right text-muted-small'>
                <em>#{transaksi.dropped_at.strftime("%d %B %Y")}</em>
              </span>"
    elsif notification.key_message == "accepted"
      sign = "<i class='fa fa-compress fa-fw'></i>&nbsp;"
      span = "<span class='pull-right text-muted-small'>
                <em>#{transaksi.accepted_at.strftime("%d %B %Y")}</em>
              </span>"
    end

    admin = User.joins(:role).where("roles.role_name = 'Super Admin'").first.id
    pengadaan = User.joins(:role).where(outlet_id: notification.recipient_id).where("roles.role_name = 'PIC Pengadaan'").first.id
    gudang = User.joins(:role).where(outlet_id: notification.recipient_id).where("roles.role_name = 'PIC Gudang'").first.id
    pimpinan = User.joins(:role).where(outlet_id: notification.recipient_id).where("roles.role_name = 'Pimpinan Outlet'").first.id
    link_admin = "<li class='notif'>" +
      "<a href='/notifications/#{notification.id}/adminRead' style='#{style}'>"+
        "#{sign}#{complete_message}#{span}"+
      "</a>"+
    "</li>"
    link_pimpinan = "<li class='notif'>"+
      "<a href='/notifications/#{notification.id}/pimpinanRead' style='#{style}'>"+
        "#{sign}#{complete_message}#{span}"+
      "</a>"+
    "</li>"
    link_gudang = "<li class='notif'>
      <a href='/notifications/#{notification.id}/otherRead' style='#{style}'>
        #{sign}#{complete_message}#{span}
      </a>
    </li>"
    link_pengadaan = "<li class='notif'>
      <a href='/notifications/#{notification.id}/otherRead' style='#{style}'>
        #{sign}#{complete_message}#{span}
      </a>
    </li>"
    b = [[admin,link_admin],[pengadaan,link_pengadaan],[gudang,link_gudang],[pimpinan,link_pimpinan]]
    return b
  end

end