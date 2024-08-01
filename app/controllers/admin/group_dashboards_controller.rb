class Admin::GroupDashboardsController < ApplicationController
  layout 'admin'

  def index
    @groups = Group.all
  end
end
