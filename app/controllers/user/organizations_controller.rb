# frozen_string_literal: true

class User::OrganizationsController < UserController
  before_action :set_organization, only: %i[edit update]

  def new
    authorize Organization

    @organization = Organization.new
  end

  def edit; end

  def create
    result = ::Users::Organizations::Create.result(
      owner: current_user,
      attributes: organization_params
    )

    if result.success?
      redirect_to user_provider_projects_path, notice: 'Sua organização foi cadastrada'
    else
      flash[:alert] = result.error
      @organization = result.provider

      render :new
    end
  end

  def update
    result = ::Users::Organizations::Update.result(
      owner: current_user,
      attributes: organization_params
    )

    if result.success?
      flash[:notice] = 'Sua organização foi atualizada'
      render :edit
    else
      flash[:alert] = result.error
      render :edit
    end
  end

  private

  def organization_params
    params.require(:organization).permit(:title, :email, :phone_number).to_h
  end

  def set_organization
    @organization = policy_scope(Organization).friendly.find(params[:id])

    authorize @organization
  end
end
