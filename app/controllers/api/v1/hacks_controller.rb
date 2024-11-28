class Api::V1::HacksController < Api::BaseController
  def index
    filters = combined_filters
    q = Hack.ransack(filters)
    render json: q.result.distinct, status: :ok
  end

  def synchronize
    hacks = Hack.completed.unsynchronized
    hack_ids = hacks.ids
    hacks.update_all(synchronized: true)
    hacks = Hack.where(id: hack_ids)
    render json: hacks, status: :ok
  end

  def show
    hack = Hack.find(params[:id])
    render json: hack, status: :ok
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
      is_advice_eq: params.dig(:q, :is_advice_eq),
      source_id_eq: params.dig(:q, :source_id_eq),
      hack_categories_category_id_in: combined_filter_ids
    }
  end
end
