module ApplicationHelper
  def post_written_by(post = @post)
    if post.user_id.nil?
      "Anonybus"
    else
      User.find(post.user_id).username
    end
  end

  def comment_written_by(comment = @comment)
    if comment.user_id.nil?
      "Anonybus"
    else
      User.find(comment.user_id).username
    end
  end
end
