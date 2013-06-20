module ApplicationHelper
  def post_written_by(post = @post)
      User.find(post.user_id).username
  end

  def comment_written_by(comment = @comment)
      User.find(comment.user_id).username
  end

  def fixed_url(str)
    str.starts_with?('http://') ? str : "http://#{str}"
  end
end
