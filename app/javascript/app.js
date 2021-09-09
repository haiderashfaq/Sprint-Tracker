require ('select2')
import 'datatables.net-bs5'; 
$(document).ready(function() {
  $(".js-select-field").select2({
  });

  $('body').on('select2:open', '.js-select-field', () => {
    document.querySelector('.select2-search__field').focus();
  });
  dateTimeFunc();
  $("#modal").on('shown.bs.modal', dateTimeFunc);
});


var dateTimeFunc =  function(){
  $(".js-flatpickr-datetime").flatpickr({
    enableTime: true
  });
}

jQuery(document).ready(function() {
 $('#issues-datatable').dataTable({
    "paging": false,
    "searching": false,
    "info": false
  });
});
