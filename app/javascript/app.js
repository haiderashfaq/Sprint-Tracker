require('select2')
$(document).ready(function() {
  $('#issues-datatable').dataTable({
    "paging": false,
    "searching": false,
    "info": false
  });

  $('.js-registration-form .js-name-field').on('keyup', function() {
    var subdomain = $("#name").val().toLowerCase();
    $('#subdomain').val(subdomain.replace(/[^a-z0-9]/g, '').substring(0, 25));
  });


  $('.js-select-field').select2({
    width: 200
  });

  $(document).on('select2:select', ".js-sprint-field", function(e) {
    $('#no-resource').remove();
    $('.btn-sprint-filter').click();
  });
   $('.js-sprint-field').select2({
    width: 200
  });
  dateTimeFunc();

  $('body').on('select2:open', '.js-select-field-single', () => {
    document.querySelector('.select2-search__field').focus();
  });

  $('body').on('select2:open', '.js-select-field', () => {
    document.querySelector('.select2-search__field').focus();
  });

  dateTimeFunc();
  $("#modal").on('shown.bs.modal', function() {
    dateTimeFunc();
    select2_field_js();
  });

  $(document).on('select2:select', ".js-filter-field", function(e) {
    var select_container_id = e.params.data["id"];
    $('.btn-apply-filter').show();
    $("#" + select_container_id).addClass('show');
    $(".js-" + select_container_id + "-field").prop("disabled", false);
    $('.btn-apply-filter').show();
    $('.btn-remove-filter').hide();
  });

  $('.js-remove-filter').on('click', function(e){
    e.preventDefault();
    var parent = this.parentNode.parentNode.id;
    var id ="#"+parent
    var className = ".js-"+parent+"-field"
    $(id).removeClass('show');
    $(className).prop( "disabled", true );
    var data = $('form').serialize();
    if (data.match(/&/g).length < 2)
    {
      $('.btn-apply-filter').hide();
      $('.btn-remove-filter').show();
    }
  });

  if (window && window.localStorage.getItem('sidebar') === 'active') {
    // if it active show it as active
    $("#sidebar").addClass("active");
  } else {
    $("#sidebar").removeClass("active");
  }

  $("#menu-btn").click(function() {
    $("#sidebar").toggleClass("active");
  });
});

var dateTimeFunc = function() {
  $(".js-flatpickr-datetime").flatpickr({
    enableTime: true
  });
}


window.addEventListener("ajax:success", (event) =>{
  $('#modal').on('shown.bs.modal', function(){
    $(".js-select-form-field").select2({
      dropdownParent: $('#modal')
    }); 
  });

});
var select2_field_js = function() {
  $(".js-select-field-single").select2({});
}