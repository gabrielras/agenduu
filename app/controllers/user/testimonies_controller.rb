# frozen_string_literal: true

class User::TestimoniesController < UserController
  before_action :set_testimony, only: %i[edit update destroy]

  def index
    @q = policy_scope(Testimony).ransack(params[:q])
    result = @q.result(distinct: true).order(created_at: :desc)
    @pagy, @testimonies = pagy(result, items: 10)
  end

  def update
    result = ::Users::Testimonies::Update.result(
      testimony: @testimony,
      attributes: testimony_params
    )

    if result.success?
      redirect_to edit_user_group_path(result.group), notice: 'atualizado'
    else
      flash[:alert] = result.error

      render :edit
    end
  end

  private

  def testimony_params
    params.require(:testimony).permit(:).to_h
  end

  def set_testimony
    @testimony = policy_class(Testimony).find(params[:id])
  end
end
