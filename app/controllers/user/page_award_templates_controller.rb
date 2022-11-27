# frozen_string_literal: true

class User::PageAwardTemplatesController < UserController
  layout 'blank', only: [:edit]
  before_action :set_award, :set_page_award_template

  def edit; end

  def update
    result = ::Users::PageAwardTemplates::Update.result(
      attributes: page_award_template_params,
      page_award_template: @page_award_template
    )

    if result.success?
      redirect_to user_award_path(@award), notice: 'Atualizado'
    else
      flash[:alert] = result.error

      render :edit
    end
  end

  private

  def page_award_template_params
    params.require(:page_award_template).permit(
      :title, :description, :text_submit, :primary_color, :secondary_color
    )
  end

  def set_page_award_template
    @page_award_template = policy_scope(PageAwardTemplate).find(params[:id])
  end

  def set_award
    @award = policy_scope(Award).find(params[:award_id])
  end
end
