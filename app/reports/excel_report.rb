class ExcelReport
  attr_reader :comments

  def initialize(comments=[])
    @comments = comments
  end

  def export
    book = Spreadsheet::Workbook.new
    sheet = book.create_worksheet
    sheet[0, 0] = "Post title:"
    sheet[0, 1] = comments.first.commentable.title
    comments.each_with_index do |comment, index|
      sheet[index+1, 0] = comment.body
    end

    book
  end
end
