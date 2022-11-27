# frozen_string_literal: true

class User::RewardsController < UserController
  before_action :set_reward, only: %i[destroy]

  def index
  end

  def new
    @reward = Reward.new
  end

  def create
    result = ::Users::Rewards::Create.result(
      attributes: rewards_params
    )

    if result.success?
      redirect_to user_rewards_path, notice: 'criado'
    else
      redirect_to user_rewards_path, alert: result.error
    end
  end

  def destroy
    result = ::Users::Rewards::Destroy.result(reward: @reward)

    if result.success?
      redirect_to user_rewards_path, notice: 'removido'
    else
      redirect_to user_rewards_path, alert: result.error
    end
  end

  private

  def reward_params
    params.require(:reward).permit(:affiliate_id, :lead_id)
  end

  def set_reward
    @reward = policy_scope(Reward).find(params[:id])
  end
end
