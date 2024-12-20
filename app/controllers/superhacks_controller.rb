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

  def download_pdf
    @superhack = Superhack.find(params[:id])
    @markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML)

    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "superack_#{@superhack.id}",
               template: 'superhacks/pdf'
      end
    end
  end

  private

  def combined_filters
    combined_filter_ids = [
      params.dig(:q, :with_target_ids),
      params.dig(:q, :with_goal_ids)
    ].compact.flatten.uniq

    {
      superhack_categories_category_id_in: combined_filter_ids
    }
  end
end
