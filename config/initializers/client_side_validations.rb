# frozen_string_literal: true
# ClientSideValidations Initializer

# Disabled validators
# ClientSideValidations::Config.disabled_validators = []

# Uncomment to validate number format with current I18n locale
# ClientSideValidations::Config.number_format_with_locale = true

# Uncomment the following block if you want each input field to have the validation messages attached.
#
# Alternatively, for a cleaner approach, it is possible to set
# `config.action_view.field_error_proc` in the application configuration
#
# Note: client_side_validation requires the error to be encapsulated within
# <label for="#{instance.send(:tag_id)}" class="message"></label>
#
# ActionView::Base.field_error_proc = proc do |html_tag, instance|
#   if html_tag =~ /^<label/
#     %(<div class="field_with_errors">#{html_tag}</div>).html_safe
#   else
#     %(<div class="field_with_errors">#{html_tag}<label for="#{instance.send(:tag_id)}" class="message">#{instance.error_message.first}</label></div>).html_safe
#   end
# end
#ActionView::Base.field_error_proc = proc do |html_tag, instance|
#  %(
#    <div class="field_with_errors fixed-notification end-0 p-3">
#      <div class="bs-toast toast fade show" role="alert" aria-live="assertive" aria-atomic="true">
#        <div class="toast-header">
#          <i class="bx bx-bell me-2"></i>
#          <div class="me-auto fw-semibold">Info</div>
#          <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
#        </div>
#        <div class="toast-body">
#          #{instance.send(:tag_id)}
#          #{instance.error_message.first}
#        </div>
#      </div>
#    </div>
#  ).html_safe
#end

ActionView::Base.field_error_proc = proc do |html_tag, instance|
  if html_tag =~ /^<label/
    %(<div class="field_with_errors">#{html_tag}</div>).html_safe  
  else
    %(<div class="field_with_errors">#{html_tag}<label for="#{instance.send(:tag_id)}" class="message"><span class="badge bg-alert">#{instance.error_message.first}</span></label></div>).html_safe
  end
end
