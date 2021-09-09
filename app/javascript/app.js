require ('select2')
$(document).ready(function() {
  $(".js-select-field").select2({
  });

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


var dateTimeFunc =  function(){
  $(".js-flatpickr-datetime").flatpickr({
    enableTime: true
  });
}
