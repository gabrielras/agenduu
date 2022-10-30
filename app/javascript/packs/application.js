// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import "@hotwired/turbo-rails"
import "controllers"
import "bootstrap"
import 'boxicons';
import 'bootstrap-icons/font/bootstrap-icons.css'

require("@popperjs/core")

window.Rails = Rails
window.$ = window.jQuery = require('jquery')

require("highlightjs")
require("masonry-layout")
require("perfect-scrollbar")
require('@client-side-validations/client-side-validations')
require("@nathanvda/cocoon")

global.toastr = require("toastr")

Rails.start()
Turbolinks.start()
ActiveStorage.start()

require("trix")
require("@rails/actiontext")
require('@client-side-validations/client-side-validations')

$('.toast-container .toast-close').click(function() {
  let toast = $(this).parents('.toast-container');

  toast.fadeOut('slow', function() {
    toast.remove();
  });
});

