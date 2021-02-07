// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"

Rails.start()
Turbolinks.start()
ActiveStorage.start()

$(document).on('turbolinks:load', function() {
  window.addEventListener('resize', loadNextPage);
  window.addEventListener('scroll', loadNextPage);
  window.addEventListener('load', loadNextPage);
});

var loadNextPage = function () {
  if ($('#locations').height() === undefined || $('#next_link').data('loading')) { return }
  var wBottom = $(window).scrollTop() + $(window).height();
  var elBottom = $('#locations').offset().top + $('#locations').height();

  if (wBottom > elBottom) {
    if ($('#next_link')[0] !== undefined) {
      $('#next_link')[0].click();
      $('#next_link').data('loading', true);
    }
  }
};
