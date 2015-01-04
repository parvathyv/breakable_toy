module Admin
  class ArticlesController < ApplicationController
    before_filter :admin_authorize!

    def destroy
      @article = Article.find(params[:id])
      @article = Article.find(params[:id]).destroy

      if @article.destroy
        redirect_to articles_path, :notice => "Article successfully deleted"
      else
        render :edit, :notice => "Article did not delete"
      end
    end

    def edit
      @article = Article.find(params[:id])
    end
  end
end

