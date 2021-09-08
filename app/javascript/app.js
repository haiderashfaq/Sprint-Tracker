$(document).ready(function() {
  $(".js-select-field-single").select2({
  });
  $('body').on('select2:open', '.js-select-field', () => {
    document.querySelector('.select2-search__field').focus();
  });
  dateTimeFunc();
  $("#modal").on('shown.bs.modal', dateTimeFunc);
});


var dateTimeFunc =  function(){
  $(".js-flatpickr-datetime").flatpickr({});
}