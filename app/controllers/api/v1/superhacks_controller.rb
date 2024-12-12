class Api::V1::SuperhacksController < Api::BaseController
  def categories
    render json: { categories: Category.all, classifications: Classification.all }, status: :ok
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
