class CommentsController < ApplicationController
  before_action :find_commentable

  def index
    @comments = @commentable.comments
    json_response @comments
  end  

  private

    def find_commentable
      @commentable = Comment.find_by_id(params[:comment_id]) if params[:comment_id]
      @commentable = Post.find_by_id(params[:post_id]) if params[:post_id]
    end

    def comment_params
      params.permit(:body)
    end
end
