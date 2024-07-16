class Admin::PostCommentDashboardsController < ApplicationController
  layout 'admin'

  def index
    @post_comments = PostComment.all
    @users = User.all
  end

end
