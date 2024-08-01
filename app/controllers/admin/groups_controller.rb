class Admin::GroupsController < ApplicationController

  def destroy
    @group = Group.destroy(params[:id])
    @group.destroy
    redirect_to admin_group_dashboards_path
  end

end
