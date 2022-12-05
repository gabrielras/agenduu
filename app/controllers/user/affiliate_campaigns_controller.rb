# frozen_string_literal: true

class User::AffiliateCampaignsController < UserController
  before_action :set_affiliate_campaign

  def show; end

  def affiliate; end

  def share_with_affiliate; end

  def share_with_lead; end

  def edit
    @reward = organization.decorate.reward_main
  end

  def update
    result = ::Users::AffiliateCampaigns::Update.result(
      attributes: affiliate_campaigns_params,
      affiliate_campaign: @affiliate_campaign
    )

    if result.success?
      redirect_to user_affiliate_campaign_path(@affiliate_campaign), notice: 'atualizado'
    else
      flash[:alert] = result.error

      render :edit
    end
  end

  private

  def affiliate_campaign_params
    params.require(:affiliate_campaign).permit(
      :title, :subtitle, :description, :title_form, :subtitle_form,
      :rule_title, :rule_description, :background_color, :primary_color, :secondary_color,
      rewards_attributes: [:id, :to_affiliate, :to_lead, :social_network, :username]
    ).merge(organization: current_user.organization).to_h
  end

  def set_affiliate_campaign
    @affiliate_campaign = policy_scope(AffiliateCampaign).find(params[:id])
  end
end
