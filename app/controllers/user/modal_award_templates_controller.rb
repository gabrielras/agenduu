# frozen_string_literal: true

class User::ModalAwardTemplatesController < UserController
  before_action :set_award, :set_modal_award_template

  def edit; end

  def update
    result = ::Users::ModalAwardTemplates::Update.result(
      attributes: modal_award_template_params,
      modal_award_template: @modal_award_template
    )

    if result.success?
      redirect_to user_award_path(@award), notice: 'Atualizado'
    else
      flash[:alert] = result.error

      render :edit
    end
  end

  private

  def modal_award_template_params
    params.require(:modal_award_template).permit(
      :title, :description, :text_submit, :primary_color, :secondary_color
    )
  end

  def set_modal_award_template
    @modal_award_template = policy_scope(ModalAwardTemplate).find(params[:id])
  end

  def set_award
    @award = policy_scope(Award).find(params[:award_id])
  end
end
