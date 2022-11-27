# frozen_string_literal: true

class User::PartnershipAwardsController < UserController
  before_action :set_award, except: %i[index new]

  def index
    @q = policy_scope(Award).where(type_of_award: 'partnership').ransack(params[:q])
    result = @q.result(distinct: true).order(created_at: :desc)
    @pagy, @awards = pagy(result, items: 10)
  end

  def new
    @award = Award.new
  end

  def show; end

  def edit; end

  def create
    result = ::Users::PartnershipAwards::Create::Received.result(
      attributes: awards_params
    )

    if result.success?
      redirect_to user_partnership_award_path(@award), notice: 'criado'
    else
      flash[:alert] = result.error
      @award = result.award

      render :new
    end
  end

  def update
    result = ::Users::PartnershipAwards::Update.result(
      attributes: awards_params,
      award: @award
    )

    if result.success?
      redirect_to user_partnership_award_path(@award), notice: 'atualizado'
    else
      flash[:alert] = result.error

      render :edit
    end
  end

  def destroy
    result = ::Users::Awards::Destroy.result(award: @award)

    if result.success?
      redirect_to user_partnership_awards_path, notice: 'removido'
    else
      redirect_to user_partnership_award_path(@award), alert: result.error
    end
  end

  private

  def award_params
    params.require(:award).permit(:to_affiliate, :to_lead, :rule, :business_cell_phone, :new_client)
      .merge(organization: current_user.organization, type_of_award: 'main').to_h
  end

  def set_award
    @award = policy_scope(Award).find(params[:id])
  end
end
