# frozen_string_literal: true

class UserDecorator < ApplicationDecorator
  def list_users
    object.organization.users.order(:full_name).uniq
  end

  def accessibility(project)
    Accessibility.where(user: object, group: group).take
  end
end
