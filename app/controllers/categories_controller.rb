class CategoriesController < ApplicationController
  def show
    @category = Category.find(params[:id])
    @posts = @category.posts
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(params[:category])
    if @category.save
      redirect_to category_path(@category), :flash => {:success => "You created a new category!"}
    else
      flash.now[:error] = "#{@category.errors.full_messages.join(', ')}"
      render :action => :new
    end
  end
end