require ('select2')
$(document).ready(function() {
  $('.js-remove-filter').on('click', function(e){
    e.preventDefault();
    var parent = this.parentNode.parentNode.id;
    var id ="#"+parent
    var classname = ".js-"+parent+"-field"
    $(id).hide();
    $( classname).prop( "disabled", true );
  });
  $(".js-select-field").select2({
    dropdownParent: $('#modal')
  });

  $('.js-select-field').select2({
    width: 200
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
  $('[data-toggle="tooltip"]').tooltip()
  $('[data-toggle="popover"]').popover()

  $('.js-registration-form .js-name-field').on('keyup', function(){
    var subdomain = $("#name").val().toLowerCase();
    $('#subdomain').val(subdomain.replace(/[^a-z0-9]/g, '').substring(0, 25));
  });

});
var dateTimeFunc =  function(){
  $(".js-flatpickr-datetime").flatpickr({
    enableTime: true
  });
}
$(document).on('select2:select',".js-filter-field", function (e){
    var data = e.params.data;
    var id = "#"+e.params.data["id"]
    $('.btn-filter').show();
    $(id).show();
    $( id+"_id" ).prop( "disabled", false );
    $( ".js-"+e.params.data["id"]+"-field").prop( "disabled", false );
});

