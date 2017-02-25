class ActivitiesController < ApplicationController
  include ActivitiesHelper
  def index
  	if current_user.admin?
      @activities = PublicActivity::Activity.all
    elsif current_user.pengadaan?
      @activities = PublicActivity::Activity.where(owner: current_user.user_id)
    elsif current_user.gudang? || current_user.admin_gudang? || current_user.manager?
      @activities = PublicActivity::Activity.where(trackable.outlet_id => current_user.outlet_id)
    end 
  end
  
  def sender_name(activity)
  	sender = User.find(activity.owner).user_name
  	osender = Outlet.find(activity.trackable.sender_id).outlet_name
  	return sender+" dari Apotek "+osender
  end

  def acceptor_name(activity)
  	acc = Outlet.find(activity.trackable.receiver_id).outlet_name
  	return acc
  end
end
