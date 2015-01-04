class ReviewsController < ApplicationController

  before_action :authenticate_user!, only: [:create]

  def new
    @review = Review.new
  end


  def edit
    @article = Article.find(params[:article_id])
    @review = Review.find(params[:id])
  end


  def update
    @article = Article.find(params[:article_id])
    @review = Review.find(params[:id])

    if @review.update(review_params)
      redirect_to article_path(@article), :notice => "Review successfully edited"
    else
      redirect_to article_path(@article), :notice => "Review did fail"
    end
  end

  def create
    @user = User.find(current_user.id)
    @article = Article.find(params[:article_id])
    @review = Review.new(review_params)
    @reviews = @article.reviews
    @review.article_id = @article.id
    @review.user_id = @user.id

    if @review.save
      redirect_to article_path(@article), :notice => "Review successfully added"
    else
      redirect_to article_path(@article), :notice => "Review did fail"

    end
  end

  def destroy
    @review = Review.find(params[:id])
    @article = @review.article

    if @review.destroy
      redirect_to article_path(@article), notice: "Review deleted"
    else
      render article_path(@article), notice: "Review was not deleted"
    end
  end

  private
  def review_params
    params.require(:review).permit(:body, :user_id, :article_id)
  end
end
