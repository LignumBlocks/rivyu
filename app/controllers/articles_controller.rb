class ArticlesController < ApplicationController
  def show
    @q = Hack.ransack(params[:q])
    @article = Article.find(params[:id])
  end
end
