# frozen_string_literal: true

class User::AskForTestimoniesController < UserController
  before_action :set_ask_for_testimony

  def edit
  end

  def update
    result = ::Users::AskForTestimonies::Update.result(
      ask_for_testimony: @ask_for_testimony,
      attributes: ask_for_testimony_params
    )

    if result.success?
      redirect_to edit_user_group_path(result.group), notice: 'atualizado'
    else
      flash[:alert] = result.error

      render :edit
    end
  end

  private

  def ask_for_testimony_params
    params.require(:ask_for_testimony).permit(:title, :description).to_h
  end

  def set_ask_for_testimony
    @ask_for_testimony = policy_scope(AskForTestimony).find(params[:id])
  end
end
