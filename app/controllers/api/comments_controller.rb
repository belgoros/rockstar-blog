module Api
  class CommentsController < ApplicationController
    before_action :find_commentable

    def index
      @comments = @commentable.comments
      book = ExcelReport.new(@comments).export
      file_contents = StringIO.new
      book.write file_contents
      respond_to do |format|
        format.xls do
          send_data file_contents.string, type: 'application/vnd.ms-excel', filename: 'comments.xls'
        end
      end
    end

    private

      def find_commentable
        @commentable = Comment.find_by_id(params[:comment_id]) if params[:comment_id]
        @commentable = Post.find_by_id(params[:post_id]) if params[:post_id]
      end
  end
end

