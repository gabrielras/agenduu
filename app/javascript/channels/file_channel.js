import consumer from "./consumer"

$(document).ready(function() {
  if ($('#message_channel').length > 0) {
    let preview_pane_id = $('#message_channel').attr('data-preview-pane-id');

    consumer.subscriptions.create({
      channel: `MessageClientChannel`,
      message_id: message_id
    }, {
      connected() {
        // Called when the subscription is ready for use on the server
        console.log('Conectado! - message_channel');
      },

      disconnected() {
        console.log('Desconectado! - message_channel');
        // Called when the subscription has been terminated by the server
      },

      received(data) {
        console.log('Informação recebida - message_channel')
        console.log(data);

        if (data.action === 'sent') {
         
        }

        if (data.action === 'update') {
         
        }

        if (data.action === 'remove') {

        }
      },
    })
  }
});
