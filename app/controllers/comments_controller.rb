class CommentsController < ApplicationController
  before_filter :require_user
  def new
    @post = Post.find_by_slug(params[:post_id])
    @comment = @post.comments.new
  end

  def create
    @post = Post.find_by_slug(params[:post_id])
    @comment = @post.comments.build(params[:comment])
    @comment.user = current_user
    
    if @comment.save
      redirect_to @post, :flash => {:success => "Comment added!"}
    else
      redirect_to @post, :flash => {:alert => "#{@comment.errors.full_messages.join('')}"}
    end
  end

  def vote
    Vote.create(voteable_id: params[:id], voteable_type: "Comment", value: params[:value])

    respond_to do |format|
      format.html do
        flash[:notice] = "Your vote was counted!"
        redirect_to :back
      end

      format.js
    end
  end
end