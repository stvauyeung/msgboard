class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
    @post.categorizations.new
    @select = Category.all.map { |category| [category.cat_name, category.id]}
  end

  def create
    binding.pry
    @post = Post.new(params[:post])
    if @post.save
      redirect_to @post, :flash => {:success => "You created a new post!"}
    else
      flash.now[:error] = "#{@post.errors.full_messages.join('')}"
      render :action => :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(params[:post])
      redirect_to @post, :flash => {:success => "You updated '#{@post.title}'!"}
    else
      flash.now[:error] = "#{@post.errors.full_messages.join('')}"
      render :action => :edit
    end
  end
  
end
