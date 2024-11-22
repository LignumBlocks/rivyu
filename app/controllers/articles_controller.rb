class ArticlesController < ApplicationController
  def show
    @markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML)
    @article = Article.find(params[:id])
  end
end
