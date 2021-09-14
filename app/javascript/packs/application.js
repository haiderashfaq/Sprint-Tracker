global.$ = global.jQuery = require("jquery");
import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import dt from "datatables.net";
import 'datatables.net-bs5'; 

require ('../app');
require('select2')
require('datatables.net-bs5')
require("bootstrap")
require("../app.js")
require("flatpickr");

document.addEventListener("turbolinks:load", function() {
  $(function () {
    $('[data-toggle="tooltip"]').tooltip()
    $('[data-toggle="popover"]').popover()
  })
})

Rails.start()
// Turbolinks.start()
ActiveStorage.start()

$('.js-select-field').on('select2:select', function (e) {
  debugger
    var data = e.params.data;
    console.log(data);
});

