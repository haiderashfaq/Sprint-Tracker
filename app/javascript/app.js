require('select2')
$(document).ready(function() {
  $(".js-select-field-single").select2({});

  $('body').on('select2:open', '.js-select-field', () => {
    document.querySelector('.select2-search__field').focus();
  });
  dateTimeFunc();
  $("#modal").on('shown.bs.modal', dateTimeFunc);

  $('#issues-datatable').dataTable({
    "paging": false,
    "searching": false,
    "info": false
  });
});

// $(document).ajaxComplete(function() {
//   $('#check_all').on("click", function() {
//     console.log("Say hello")
//     var checkboxes = $("#issue_ids");
//     if (checkboxes.prop("checked")) {
//       checkboxes.prop("checked", false);
//     } else {
//       checkboxes.prop("checked", true);
//     }
//   });
// });

var dateTimeFunc = function() {
  $(".js-flatpickr-datetime").flatpickr({
    enableTime: true
  });
}