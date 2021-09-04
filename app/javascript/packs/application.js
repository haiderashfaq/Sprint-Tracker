// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import dt from "datatables.net";
import 'datatables.net-bs5'; 

global.$ = global.jQuery = require("jquery");

require('select2')
require("bootstrap")
require("../app.js")
global.$ = global.jQuery = require("jquery");

document.addEventListener("turbolinks:load", function() {
    $(function () {
        $('[data-toggle="tooltip"]').tooltip()
        $('[data-toggle="popover"]').popover()
    })
})


jQuery(document).ready(function() {
  $("#name").change(function(){
  $("#subdomain").val($("#name").val())
});
  
});

$('#users-datatable').DataTable().ajax.reload();
$('#users-datatable').dataTable({
    "processing": true,
    "serverSide": true,
    "ajax": {
      "url": $('#users-datatable').data('source')
    },
    "pagingType": "full_numbers",
    "columns": [
      {"data": "name"},
      {"data": "email"},
      {"data": "role_id"}
    ]
    // pagingType is optional, if you want full pagination controls.
    // Check dataTables documentation to learn more about
    // available options.
  });

Rails.start()
Turbolinks.start()
ActiveStorage.start()

