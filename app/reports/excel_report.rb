class ExcelReport
  attr_reader :post

  def initialize(post)
    @post = post
  end

  def export
    book = Spreadsheet::Workbook.new
    sheet = book.create_worksheet

    sheet[0, 0] = "Post title:"
    sheet[0, 1] = post.title
    if post.comments.empty?
      sheet[1, 0] = "No comments yet for the post #{post.title}"
    else
      write_comments(sheet, post.comments)
    end

    book
  end

  private

  def write_comments(sheet, comments, start_row = 1)
    comments.each do |comment|
      sheet[start_row, 1] = "comment:#{comment.id}: #{comment.body}"
      comment.comments.each_with_index do |thread, t_index|
        start_row += 1
        thread_index = t_index + 1
        sheet[start_row, thread_index + 1] = "thread: #{thread.id}: #{thread.body}"
        write_comments(sheet, thread.comments, start_row + 1) if thread.comments.any?
      end
      start_row += 1
    end
  end
end
