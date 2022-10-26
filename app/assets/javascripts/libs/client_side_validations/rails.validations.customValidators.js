// The validator variable is a JSON Object
// The selector variable is a jQuery Object
window.ClientSideValidations.validators.local['cpf_cnpj'] = function(element, options) {
  // Your validator code goes in here
  if ( element.val() && validCpf(element.val()) === false && validCnpj(element.val()) === false ) {
    // When the value fails to pass validation you need to return the error message.
    // It can be derived from validator.message
    return options.message;
  }
}

// The validator variable is a JSON Object
// The selector variable is a jQuery Object
window.ClientSideValidations.validators.local['cpf'] = function(element, options) {
  // Your validator code goes in here
  if ( element.val() && validCpf(element.val()) === false ) {
    // When the value fails to pass validation you need to return the error message.
    // It can be derived from validator.message
    return options.message;
  }
}


// Valida o formato do CEP.
window.ClientSideValidations.validators.local['cep'] = function(element, options) {
  var validacep = /^[0-9]{5}-[0-9]{3}$/;
  if ( element.val() && !validacep.test(element.val()) ) {
    return options.message;
    }
}

// Valida o formato do Email.
window.ClientSideValidations.validators.local['email'] = function(element, options) {
  if ( element.val() && !/^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i.test(element.val())) {
    return options.message;
  }
}

function exibirMsgErro(el, msg, style) {
  // console.log(el.val());
  // console.log(msg);
  el.parent().find('.invalid-feedback').remove();

  if (msg === undefined){ msg = 'não pode ficar em branco'; }
  el.removeClass("is-valid");
  el.removeClass("validate");
  el.addClass("invalid");
  el.addClass('is-invalid');

  el.parent().append(`
    <div class='invalid-feedback required-validation' style='${style}'>
      ${msg}
    </div>
  `);
  el.focus();
}

function removerMsgErro(el) {
  if ( el.parent().find('.invalid-feedback.required-validation').length > 0 ){
    el.addClass("is-valid");
    el.addClass("validate");
    el.removeClass("invalid");
    el.removeClass('is-invalid');

    el.parent().find('.invalid-feedback.required-validation').remove();
  }
}

function validarElements(elements, form){
  let valid = true;
  $.each(elements, function(index, element){
    let el = form.find('#' + element.id);

    // passa ao prox se o campo nao for requerido
    if ( el.attr('required') === undefined ) {
      alert('el')
      return;
    }
    if (el.attr('type') === 'radio') {
      let isSet = false;
      let parentDiv = el.parents('.row-radio')
      let errorDiv = parentDiv.children().first();
      parentDiv.children().find('input').each(function() {
        isSet = isSet || $(this).is(':checked');
      });
      if (!isSet) {
        valid = false;
        exibirMsgErro(errorDiv, undefined, 'padding-left: calc(var(--bs-gutter-x) * .5);');
      } else {
        removerMsgErro(errorDiv);
      }
    } else {
      // se o campo e requerido e esta em branco
      if ( el.val() === '' || el.val() === undefined ) {
        valid = false;
        exibirMsgErro(el);
      } else {
        removerMsgErro(el);
      }
    }
  })
  return valid;
}

$(document).ready(function(){
  $('form.require-validation').submit(function(){
    let form = $(this);
    let elements = form.find(':input[required=required]');

    return validarElements(elements, form);
  })

  $('form.require-validation :input').change(function(){
    let el = $(this);

    if ( el.attr('required') === undefined ) {
      return true;
    }
    // se o campo e requerido e esta em branco
    if ( el.val() === '' || el.val() === undefined ) {
      // console.log(`em branco: ${el.attr('id')}`);
      exibirMsgErro(el);
      return false;
    } else {
      // console.log(`preenchido: ${el.attr('id')}`);
      removerMsgErro(el);
      return true;
    }
  })
})
