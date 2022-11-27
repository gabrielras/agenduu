# frozen_string_literal: true

class User::AwardsController < UserController
  before_action :set_award, except: %i[index new create]

  def index
    @award = policy_scope(Award).where(type_of_award: 'main').take
    redirect_to user_award_path(@award) if @award.present?
  end

  def new
    @award = Award.new
  end

  def show; end

  def edit; end

  def create
    result = ::Users::Awards::Create::Received.result(
      attributes: award_params
    )

    if result.success?
      redirect_to user_award_path(result.award), notice: 'criado'
    else
      flash[:alert] = result.error
      @award = result.award

      render :new
    end
  end

  def update
    result = ::Users::Awards::Update.result(
      attributes: award_params,
      award: @award
    )

    if result.success?
      redirect_to user_award_path(@award), notice: 'criado'
    else
      flash[:alert] = result.error

      render :edit
    end
  end

  def destroy
    result = ::Users::Awards::Destroy.result(award: @award)

    if result.success?
      redirect_to user_awards_path, notice: 'removido'
    else
      redirect_to user_award_path(@award), alert: result.error
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
