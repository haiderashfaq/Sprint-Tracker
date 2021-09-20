require('select2')
$(document).ready(function() {
  $(".js-select-field-single").select2({});

  $('body').on('select2:open', '.js-select-field-single', () => {
    document.querySelector('.select2-search__field').focus();
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

  $('.js-remove-filter').on('click', function(e) {
    e.preventDefault();
    var parent = this.parentNode.parentNode.id;
    var id = "#" + parent
    var className = ".js-" + parent + "-field"
    $(id).hide();
    $(className).prop("disabled", true);
  });

  $('.js-select-field').select2({
    width: 200
  });

  $(document).on('select2:select', ".js-select-field", function(e) {
    var select_container_id = e.params.data["id"];
    $('.btn-filter').show();
    $("#" + select_container_id).addClass('show');
    $(".js-" + select_container_id + "-field").prop("disabled", false);
  });


  dateTimeFunc();
  $("#modal").on('shown.bs.modal', dateTimeFunc);


  if (window && window.localStorage.getItem('sidebar') === 'active') {
      // if it active show it as active
      $("#sidebar").addClass("active");
  } else {
      $("#sidebar").removeClass("active");
  } 


 $("#menu-btn").click(function() {
       $("#sidebar").toggleClass("active");
       var updated = '';
       if (window.localStorage.getItem('sidebar') === 'active') {
           updated = 'not_active';
       } else {
           updated = 'active';
       }
       window.localStorage.setItem('sidebar', updated);
  });
});


var dateTimeFunc = function() {
  $(".js-flatpickr-datetime").flatpickr({
    enableTime: true
  });
}