// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
// import 'datatables.net-bs5'; 
require('select2')
require("bootstrap")
global.$ = global.jQuery = require("jquery");
// import "../stylesheets/application";
document.addEventListener("turbolinks:load", function() {
    $(function () {
        $('[data-toggle="tooltip"]').tooltip()
        $('[data-toggle="popover"]').popover()
    })
})

Rails.start()
Turbolinks.start()
ActiveStorage.start()


var select2func = function() {
  $(".js-example-matcher").select2({
    dropdownCssClass: 'select2-small-dropdown-container select2-small-container'
  });
}

$(document).ready(select2func);
$(document).on('turbolinks:load', select2func);

 $(document).on('select2:open', () => {
    document.querySelector('.select2-search__field').focus();
  });
// jQuery(document).ready(function() {
//  $('#issues-datatable').dataTable({
//     "paging": false,
//     "searching": false,
//     "info": false
//   });
// });
