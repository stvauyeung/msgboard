class CommentsController < ApplicationController
  def new
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(params[:comment])
    if @comment.save
      redirect_to @post, :flash => {:success => "Comment added!"}
    else
      redirect_to @post, :flash => {:alert => "#{@comment.errors.full_messages.join('')}"}
    end
  end
end