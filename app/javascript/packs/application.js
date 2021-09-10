// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.


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

