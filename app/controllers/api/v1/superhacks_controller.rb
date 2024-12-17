class Api::V1::SuperhacksController < Api::BaseController
  def categories
    categories = Category.for_super_hacks
    classifications = Classification.where(id: categories.map(&:classification_id).uniq)

    render json: { categories: categories, classifications: classifications }, status: :ok
  end

  def create
    super_hack = Superhack.new(superhack_params)
    super_hack.category_ids = params[:category_ids]
    super_hack.hack_ids = params[:hack_ids]

    if super_hack.save
      render json: { superhack: super_hack }, status: :ok
    else
      render json: { error: super_hack.errors.full_messages.to_sentence }, status: :unprocessable_entity
    end
  rescue StandardError => e
    render json: { error: e.message }, status: :unprocessable_entity
    end

  def combined_hacks
    combined_hack = CombinedHack.last
    if combined_hack
      render json: { combined_hack: combined_hack }, status: :ok
    else
      render json: { message: 'No CombinedHack record found.' }, status: :not_found
    end
  end

  def save_combined_hacks
    combined_hack = CombinedHack.last
    combined_hack ||= CombinedHack.new

    if params[:data].present?
      combined_hack.data = params[:data]
      if combined_hack.save
        render json: { combined_hack: combined_hack }, status: :ok
      else
        render json: { error: combined_hack.errors.full_messages.to_sentence }, status: :unprocessable_entity
      end
    else
      render json: { error: 'Data parameter is missing.' }, status: :bad_request
    end
  end

  private

  def superhack_params
    params.require(:superhack).permit(
      :id,
      :title,
      :description,
      :implementation_steps,
      :expected_results,
      :risks_and_mitigation
    )
  end
end
