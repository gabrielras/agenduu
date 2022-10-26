# frozen_string_literal: true

# FlashMessagesHelper
module FlashMessagesHelper
  include RenderHamlHelper

  # boostrap alert para flash messages e object.errors
  # @param object (ModelObject)
  # @return html
  def flash_message(object = nil)
    messages = { flash: messages_in_flash }
    haml = write_flash_messages(messages[:flash])
    return haml unless object

    messages[:object] = messages_in_object(object)
    haml += write_flash_messages(messages[:object])
    haml.html_safe
  end

  # busca no flash[], se algum possui mensagens
  # @return Array [Symbol, String]
  def messages_in_flash
    messages = []
    %i[notice success alert error information].each do |flash_type|
      next if flash[flash_type].blank?

      flash[flash_type].split('<br/>').each do |message|
        error_message = message.split(':').join(':<br/>')
                               .split(',').join('.<br/>')
        error_message += '.'

        messages << [flash_type, error_message]
      end
      flash[flash_type] = nil
    end
    messages
  end

  # Busca mensagens de erro no objeto
  # @param object (ModelObject)
  # @return Array [Symbol, String]
  def messages_in_object(object = nil)
    return [] if object.nil? || object.errors.full_messages.blank?

    messages = []
    object.errors.full_messages.uniq.each do |error|
      messages << [:error, error.to_s]
    end
    messages
  end

  # recebe o tipo de mensagem a ser exibida e retorna o titulo
  # @param type (success, alert, warning, ...)
  # @return String
  def message_title_by(type)
    message_title_class_by(type)[0]
  end

  # recebe o tipo de mensagem a ser exibida e retorna a classe do css
  # @param type (success, alert, warning, ...)
  # @return String
  def message_class_by(type)
    message_title_class_by(type)[1]
  end

  def message_title_class_by(type)
    case type
    when :success, :notice then ['Informação: ', 'bg-success']
    when :alert, :warning  then ['Atenção: ', 'bg-warning']
    when :error            then ['Erros: ', 'bg-danger']
    when :information      then ['Nota: ', 'bg-info']
    else %w[Mensagem bg-info]
    end
  end

  def write_flash_messages(messages)
    return '' if messages.blank?

    type = messages.first.first
    css = message_class_by(type)

    render_haml <<-HAML, messages: messages, type: type, css: css
      .toast-container.fixed-notification.end-0.p-3
        - messages.each do |type, message|
          .fade.bs-toast.toast.show{"aria-atomic" => "true", "aria-live" => "assertive", :role => "alert", class: css}
            .toast-header
              %i.bx.bx-bell.me-2
              .me-auto.fw-semibold= message_title_by(type)
              %button.btn-close{"aria-label" => "Close", "data-bs-dismiss" => "toast", :type => "button"}
            .toast-body
              = message
    HAML
  end
end
