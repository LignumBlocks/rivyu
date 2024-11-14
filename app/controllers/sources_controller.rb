class SourcesController < ApplicationController
  def index
    @sources = Source.all
    @q = @sources.ransack(params[:q])
    @pagy, @sources = pagy(@q.result, items: 25)
  end

  def show
    @source = Source.find(params[:id])
    @q = @source.articles.ransack(params[:q])
    @pagy, @articles = pagy(@q.result, items: 50)
    @article = @articles.find(params[:article_id]) if params[:article_id]
  end

  private

  def validation_source_params
    params.require(:validation_source).permit(:name, :url_query)
  end
end
