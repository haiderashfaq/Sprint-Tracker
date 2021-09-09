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

    $('.js-registration-form .js-name-field').on('keyup', function(){
      var subdomain = $("#name").val().toLowerCase();
      $('#subdomain').val(subdomain.replace(/[^a-z0-9]/g, '').substring(0, 25));
    });
    // $('#users-datatable').DataTable().ajax.reload();
    // $('#users-datatable').dataTable({
    //     "processing": true,
    //     "serverSide": true,
    //     "ajax": {
    //       "url": $('#users-datatable').data('source')
    //     },
    //     "pagingType": "full_numbers",
    //     "columns": [
    //       {"data": "name"},
    //       {"data": "email"},
    //       {"data": "role_id"}
    //     ]
    //     // pagingType is optional, if you want full pagination controls.
    //     // Check dataTables documentation to learn more about
    //     // available options.
    //   });
    // jQuery(document).ready(function() {
    //  $('#issues-datatable').dataTable({
    //     "paging": false,
    //     "searching": false,
    //     "info": false
    //   });
    // });
    
});
var dateTimeFunc =  function(){
  $(".js-flatpickr-datetime").flatpickr({
    enableTime: true
  });
}

