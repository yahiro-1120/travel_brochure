class Admin::PostCommentsController < ApplicationController

  def destroy
    @post_comment = PostComment.find(params[:id])
    @post_comment.destroy
    redirect_to admin_post_comment_dashboards_path, notice: 'コメントを削除しました'
  end

end
