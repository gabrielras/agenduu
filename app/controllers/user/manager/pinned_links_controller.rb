# frozen_string_literal: true

class User::Manager::PinnedLinksController < User::Manager::ManagerController
  before_action :set_group
  before_action :set_pinned_link, except: %i[index new create]

  def index
    @q = policy_scope(PinnedLink).where(group: @group).ransack(params[:q])
    result = @q.result(distinct: true).order(title: :asc)
    @pagy, @pinned_links = pagy(result, items: 10)
  end

  def new
    @pinned_link = PinnedLink.new
  end

  def edit; end

  def create
    result = ::Users::Manager::PinnedLinks::Create.result(
      attributes: pinned_link_params
    )

    if result.success?
      redirect_to user_manager_group_pinned_links_path(@group), notice: 'atualizado'
    else
      @message_error = result.error
      @pinned_link = result.pinned_link

      render :new, status: :unprocessable_entity 
    end
  end

  def update
    result = ::Provider::Manager::PinnedLinks::Update.result(
      pinned_link: @pinned_link,
      attributes: pinned_link_params
    )

    if result.success?
      redirect_to user_manager_group_pinned_links_path(@group), notice: 'atualizado'
    else
      @message_error = result.error
      @pinned_link = result.pinned_link

      render :edit, status: :unprocessable_entity 
    end
  end

  def move_to
  end

  private

  def pinned_link_params
    params.require(:pinned_link).permit(:title, :link).merge(group: @group).to_h
  end

  def set_pinned_link
    @pinned_link = policy_scope(PinnedLink).friendly.find(params[:id])
  end

  def set_group
    @group = policy_scope(Group).friendly.find(params[:group_id])
  end
end
