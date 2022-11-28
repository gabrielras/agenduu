# frozen_string_literal: true

class User::PartnershipsController < UserController
  before_action :set_partnership, except: %i[index new]

  def index
    @q = policy_scope(Partnership).where(type_of_partnership: 'partnership').ransack(params[:q])
    result = @q.result(distinct: true).order(created_at: :desc)
    @pagy, @partnerships = pagy(result, items: 10)
  end

  def new
    @partnership = Partnership.new
  end

  def show; end

  def edit; end

  def create
    result = ::Users::PartnershipPartnerships::Create::Received.result(
      attributes: partnerships_params
    )

    if result.success?
      redirect_to user_partnership_path(@partnership), notice: 'criado'
    else
      flash[:alert] = result.error
      @partnership = result.partnership

      render :new
    end
  end

  def update
    result = ::Users::PartnershipPartnerships::Update.result(
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

  def destroy
    result = ::Users::Partnerships::Destroy.result(partnership: @partnership)

    if result.success?
      redirect_to user_partnerships_path, notice: 'removido'
    else
      redirect_to user_partnership_path(@partnership), alert: result.error
    end
  end

  private

  def partnership_params
    params.require(:partnership).permit(
      :title, :subtitle, :description, :title_form, :subtitle_form,
      :rule_title, :rule_description, :background_color, :primary_color, :secondary_color
    ).merge(organization: current_user.organization).to_h
  end

  def set_partnership
    @partnership = policy_scope(Partnership).find(params[:id])
  end
end
