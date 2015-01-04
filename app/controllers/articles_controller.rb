class ArticlesController < ApplicationController

  before_action :authenticate_user!, only: [:destroy, :delete, :new, :create, :edit, :update]
  def new
    @article = Article.new
  end

  def create
    @user = User.find(current_user.id)
    @article = @user.articles.build(article_params)
    if @article.save
      redirect_to article_path(@article), :notice => "Article successfully added"
    else
      render :new
    end
  end

  def index
    @articles = Article.order(created_at: :desc).page(params[:page]).per(10)
  end

  def show
    @article = Article.find(params[:id])
    @reviews = @article.reviews.order(created_at: :desc)
    @review = Review.new
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if current_user.id != @article.user_id
      redirect_to @article, :notice => "Invalid user"
    else
      if @article.update_attributes(article_params)
        redirect_to edit_article_path, :notice => "Article successfully edited"
      else
        render :edit, :notice => "Article did not update"
      end
    end
  end

  def destroy
   @article = Article.find(params[:id])
    if current_user.id != @article.user_id
      redirect_to @article, :notice => "Invalid user"
    else
      @article = Article.find(params[:id]).destroy
      if @article.destroy
        redirect_to articles_path, :notice => "Article successfully deleted"
      else
        render :edit, :notice => "Article did not delete"
      end
    end
  end

  private

  def article_params
    params.require(:article).permit(:name, :description, :url, :vote_count)
  end
end
