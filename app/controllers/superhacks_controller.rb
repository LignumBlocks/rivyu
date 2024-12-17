require 'open-uri'

class SuperhacksController < ApplicationController
  def index
    filters = combined_filters
    @q = Superhack.ransack(filters)
    @pagy, @superhacks = pagy(@q.result.distinct.order(created_at: :desc), items: 50, size: [1, 3, 3, 1])
    @q = Superhack.ransack(params[:q])
  end

  def show
    @superhack = Superhack.find(params[:id])
    @markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML)
  end

  private

  def combined_filters
    combined_filter_ids = [
      params.dig(:q, :with_scale_ids),
      params.dig(:q, :with_popularity_ids),
      params.dig(:q, :with_financial_topic_ids),
      params.dig(:q, :with_audience_ids),
      params.dig(:q, :with_horizon_ids),
      params.dig(:q, :with_risk_ids),
      params.dig(:q, :with_implementation_ids),
      params.dig(:q, :with_financial_ids),
      params.dig(:q, :with_knowledge_ids)
    ].compact.flatten.uniq

    filters = {
      hack_categories_category_id_in: combined_filter_ids
    }
  end
end
