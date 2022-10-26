$(document).ready(function () {
  bsCustomFileInput.init();
  $('[data-toggle="tooltip"]').tooltip();
  $('select[data-dynamic-selectable-url][data-dynamic-selectable-target]').dynamicSelectable();
  $('select.selectpicker').selectpicker();

  let nav_show = true;
  $('#nav-menu').click(function(){
    nav_show = !nav_show
    if (nav_show) {
      $('.link-title').show();
    } else {
      $('.link-title').hide();
    }
  });

  // $('.collapse.collapse-horizontal.show').bind('mouseover', function(){
  //   nav_show = true
  //   $('.link-title').show();
  // });
  //
  // $('.collapse.collapse-horizontal.show').bind('mouseout', function(){
  //   nav_show = false
  //   $('.link-title').hide();
  // });

  // let textareaCounter = $('.letter-counter').parent().children('textarea');
  // textareaCounter.bind('keypress', function() { updateCounter($(this)); })
  // textareaCounter.bind('change', function() { updateCounter($(this)); })
  // textareaCounter.each(function() { updateCounter($(this)); })
})

