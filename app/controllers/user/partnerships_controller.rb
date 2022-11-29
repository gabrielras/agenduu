# frozen_string_literal: true

class User::PartnershipsController < UserController
  before_action :set_partnership

  def show; end

  def affiliate; end

  def share_with_affiliate; end

  def share_with_lead; end

  def edit
    @reward = organization.decorate.reward_main
  end

  def update
    result = ::Users::Partnerships::Update.result(
      attributes: partnerships_params,
      partnership: @partnership
    )

    if result.success?
      redirect_to user_partnership_path(@partnership), notice: 'atualizado'
    else
      flash[:alert] = result.error

      render :edit
    end
  end

  private

  def partnership_params
    params.require(:partnership).permit(
      :title, :subtitle, :description, :title_form, :subtitle_form,
      :rule_title, :rule_description, :background_color, :primary_color, :secondary_color,
      rewards_attributes: [:id, :to_affiliate, :to_lead, :social_network, :username]
    ).merge(organization: current_user.organization).to_h
  end

  def set_partnership
    @partnership = policy_scope(Partnership).find(params[:id])
  end
end
