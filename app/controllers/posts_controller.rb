class PostsController < ApplicationController
  before_filter :require_user, only: [:new, :create, :edit, :update, :vote]
  before_filter :find_post, only: [:show, :edit, :update, :vote]
  before_filter :require_owner, only: [:edit, :update]

  def index
    @posts = Post.all
  end

  def show
    @comments = @post.comments[0..-1]
    @comment = @post.comments.new
  end

  def new
    @post = Post.new
    @post.categorizations.new
    @select = Category.all.map { |category| [category.cat_name, category.id]}
  end

  def create
    @post = Post.new(params[:post])
    @post.user = current_user
    @select = Category.all.map { |category| [category.cat_name, category.id]}
    
    if @post.save
      redirect_to @post, :flash => {:success => "You created a new post!"}
    else
      flash.now[:error] = "#{@post.errors.full_messages.join(', ')}"
      render :action => :new
    end
  end

  def edit
    @select = Category.all.map { |category| [category.cat_name, category.id]}
  end

  def update
    if @post.update_attributes(params[:post])
      redirect_to @post, :flash => {:success => "You updated '#{@post.title}'!"}
    else
      flash.now[:error] = "#{@post.errors.full_messages.join('')}"
      render :action => :edit
    end
  end

  def vote
    Vote.create(voteable: @post, value: params[:value])
    
    respond_to do |format|
      format.html do
        flash[:notice] = "Your vote was counted!"
        redirect_to :back
      end

      format.js
    end
  end

  private
    
    def find_post
      @post = Post.find_by_slug(params[:id])
    end
  
end
