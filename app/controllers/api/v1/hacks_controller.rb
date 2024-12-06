class Api::V1::HacksController < Api::BaseController
  def index
    filters = combined_filters
    q = Hack.ransack(filters)

    limit = params[:limit] || 10
    offset = params[:offset] || 0
    records = q.result.distinct.offset(offset).limit(limit)
    total_count = q.result.distinct.count

    render json: {
      hacks: records,
      pagination: {
        limit: limit.to_i,
        offset: offset.to_i,
        total_count: total_count
      }
    }, status: :ok
  end

  def custom_index
    q = Hack.unsent_to_python.ransack(params[:q])
    items = params[:per_page] || 100
    page = params[:page] || 1
    @pagy, records = pagy(q.result(distinct: true).order(:id), items: items, page: page)
    hash = {}
    records.each { |hack| hash[hack.id] = hack.categories.map{ |category| [category.name, category.classification.name]}}
    render json: {
      hacks: records,
      hack_categories: hash,
      pagination: {
        page: @pagy.page,
        items: @pagy.items,
        count: @pagy.count,
        pages: @pagy.pages,
        next: @pagy.next,
        prev: @pagy.prev
      }
    }, status: :ok
  end

  def mark_sent_to_python
    hacks = Hack.where(id: params[:hack_ids])
    hacks.update_all(sent_to_python: true)
    render json: 'Hacks marked as sent to python', status: :ok
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
