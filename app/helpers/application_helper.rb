module ApplicationHelper
  include FlashMessagesHelper
  include OrganizationsHelper

  include Pagy::Frontend

  def sidebar_user
    current_user.try(:organization).present? &&
    ['user/modal_award_templates', 'user/page_award_templates', 'user/reward_templates'].exclude?(controller_path)
  end
end
