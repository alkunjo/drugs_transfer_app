class NotificationsController < ApplicationController
  before_action :authenticate_user!
  before_action :notif
  before_action :set_notif, only: [:adminRead,:pimpinanRead,:otherRead]
  include NotificationsHelper
  
  def index
  	if current_user.admin?
  		@notifications = Notification.all.reverse
  	else
  		@notifications = Notification.where(recipient_id: current_user.outlet_id).reverse
  	end
  end

  def asked
  	
  end

  def dropped
  	
  end

  def accepted
  	
  end

  def adminRead
    
  end

  def pimpinanRead
    
  end

  def otherRead
    
  end

  private
    def notification_params
      params.require(:notification).permit(:readStat_admin, :readStat_receiver, :readStat_manager)
    end

    def notif
      if current_user.admin?
        @notifications = Notification.all.reverse
      else
        @notifications = Notification.where(recipient_id: current_user.outlet_id).reverse
      end
    end

    def set_notif
      @notif = Notification.find(params[:id])
    end
end
