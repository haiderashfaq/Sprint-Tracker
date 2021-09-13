require('select2')
$(document).ready(function() {
  $(".js-select-field-single").select2({});

  $('body').on('select2:open', '.js-select-field-single', () => {
    document.querySelector('.select2-search__field').focus();
  });

  $('body').on('select2:open', '.js-select-field', () => {
    $(".js-select-field").select2({});
  });

  $('#issues-datatable').dataTable({
    "paging": false,
    "searching": false,
    "info": false
  });

  $('#issues-datatable').dataTable({
    "paging": false,
    "searching": false,
    "info": false
  });

  $('.js-registration-form .js-name-field').on('keyup', function() {
    var subdomain = $("#name").val().toLowerCase();
    $('#subdomain').val(subdomain.replace(/[^a-z0-9]/g, '').substring(0, 25));
  });

  dateTimeFunc();
  $("#modal").on('shown.bs.modal', dateTimeFunc);
});

var dateTimeFunc = function() {
  $(".js-flatpickr-datetime").flatpickr({
    enableTime: true
  });
}