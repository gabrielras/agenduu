# frozen_string_literal: true

class User::AwardsController < UserController
  before_action :set_award, only: %i[destroy]

  def index
    @award = organization.award
  end

  def new
    @award = Award.new
  end

  def edit; end

  def create
    result = ::Users::Awards::Create.result(
      attributes: awards_params
    )

    if result.success?
      redirect_to user_awards_path, notice: 'criado'
    else
      redirect_to user_awards_path, alert: result.error
    end
  end

  def update
    result = ::Users::Awards::Update.result(
      attributes: awards_params,
      award: @award
    )

    if result.success?
      redirect_to user_provider_awards_path, notice: 'criado'
    else
      redirect_to user_provider_awards_path, alert: result.error
    end
  end

  def destroy
    result = ::Users::Awards::Destroy.result(award: @award)

    if result.success?
      redirect_to user_awards_path, notice: 'removido'
    else
      redirect_to user_awards_path, alert: result.error
    end
  end

  private

  def award_params
    params.require(:award).permit(:current_client, :business_cell_phone, :new_client)
      .merge(organization: current_user.organization).to_h
  end

  def set_award
    @award = policy_scope(Award).find(params[:id])
  end
end
