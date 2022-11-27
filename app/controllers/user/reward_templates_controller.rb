# frozen_string_literal: true

class User::RewardTemplatesController < UserController
  before_action :set_award, :set_reward_template

  def edit; end

  def update
    result = ::Users::RewardTemplates::Update.result(
      attributes: reward_template_params,
      reward_template: @reward_template
    )

    if result.success?
      redirect_to user_award_path(@award), notice: 'Atualizado'
    else
      flash[:alert] = result.error

      render :edit
    end
  end

  private

  def reward_template_params
    params.require(:reward_template).permit(
      :title, :description, :text_submit, :primary_color, :secondary_color
    )
  end

  def set_reward_template
    @reward_template = policy_scope(RewardTemplate).find(params[:id])
  end

  def set_award
    @award = policy_scope(Award).find(params[:award_id])
  end
end
