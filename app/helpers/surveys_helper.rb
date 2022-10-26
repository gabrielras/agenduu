# frozen_string_literal: true

# SurveysHelper
module SurveysHelper
  def options_surveys
    array = Survey.where(provider_id: current_user.role.organization_id)
                        .try(:order, :title)
    return [] unless array

    array.collect { |s| [s.title, s.id] }
  end

  def options_custumers
    array = Organization.where(company_profile_id: current_user.try(:company_profiles).find(session[:company_id]))
                          .try(:order, :title)
    return [] unless array

    array.collect { |s| [s.title, s.id] }
  end

  def options_clients
    array = User.joins(:roles).where(roles: { organization_id: currente_user.role.organization_id })
                              .try(:order, :full_name)
    return [] unless array

    array.collect { |s| [s.full_name, s.id] }
  end
end
