# frozen_string_literal: true

class User::RewardsController < UserController
  before_action :set_reward, only: %i[destroy]

  def index
    @reward = organization.reward
  end

  def new
    @award = Reward.new
  end

  def create
    result = ::Users::Rewards::Create.result(
      attributes: awards_params
    )

    if result.success?
      redirect_to user_rewards_path, notice: 'criado'
    else
      redirect_to user_rewards_path, alert: result.error
    end
  end

  def destroy
    result = ::Users::Rewards::Destroy.result(award: @award)

    if result.success?
      redirect_to user_rewards_path, notice: 'removido'
    else
      redirect_to user_rewards_path, alert: result.error
    end
  end

  private

  def reward_params
    params.require(:reward).permit(:to_affiliate, :to_lead, :rule, :business_cell_phone, :new_client)
      .merge(organization: current_user.organization).to_h
  end

  def set_reward
    @reward = policy_scope(Reward).find(params[:id])
  end
end
