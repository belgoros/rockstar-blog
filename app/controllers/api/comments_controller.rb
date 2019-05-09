module Api
  class CommentsController < ApplicationController
    before_action :find_commentable

    def index
      book = ExcelReport.new(@commentable).export
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
        @commentable = Post.find_by_id!(params[:post_id])
      end
  end
end

