class Public::PermitsController < ApplicationController
  before_action :authenticate_user!

  def create
    @group = Group.find(params[:group_id])
    permit = current_user.permits.new(group_id: params[:group_id])
    permit.save
    redirect_to request.referer
  end

  def destroy
    permit = Permit.find_by(group_id: params[:group_id])
    permit.destroy
    redirect_to request.referer
  end

end
