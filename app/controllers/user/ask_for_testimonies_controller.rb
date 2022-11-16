# frozen_string_literal: true

class User::AskForTestimonysController < User::UserController
  before_action :set_ask_for_testimony

  def edit; end
  
  def update
    result = ::Users::AskForTestimonies::Create.result(
      attributes: ask_for_testimonies_params,
      ask_for_testimony: @ask_for_testimony
    )

    if result.success?
      redirect_to edit_user_provider_ask_for_testimony_path(@ask_for_testimony), notice: 'criado'
    else
      redirect_to edit_user_provider_ask_for_testimony_path(@ask_for_testimony), alert: result.error
    end
  end

  private

  def ask_for_testimonies_params
    params.require(:ask_for_testimony).permit(:role_type, :email)
      .merge(organization: current_user.decorate.provider).to_h
  end

  def set_ask_for_testimony
    @ask_for_testimony = policy_class(AskForTestimony).find(params[:id])
  end
end
