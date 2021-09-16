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

  dateTimeFunc();
  $("#modal").on('shown.bs.modal', dateTimeFunc);

  $('body').on('click', '#check_all', function() {
    if ($('#check_all').prop("checked")) {
      $(".issue-check-box").each(function() {
        $(this).prop("checked", true);
        $(this).trigger('change');
      })
    } else {
      $(".issue-check-box").each(function() {
        $(this).prop("checked", false);
        $(this).trigger('change');
      })
    }
  });

  $('body').on('change', ".issue-check-box", function() {
    let checked = false;
    $(".issue-check-box").each(function() {
      if ($(this).prop("checked")) {
        checked = true;
      }
    })
    checked ? $(".add-issues").show() : $(".add-issues").hide()
  });

  $('body').on('click', '.add-issues-to-sprint', function() {
    let issue_ids = [];
    $('.issue-check-box').each(function() {
      if ($(this).prop("checked")) {
        issue_ids.push($(this).val());
      }
    });
    $('.issue_ids').val(issue_ids);
  });

});

var dateTimeFunc = function() {
  $(".js-flatpickr-datetime").flatpickr({
    enableTime: true
  });
}

var clickTab = function(id) {
  $(id).tab('show');
  $.get($(id).prop('href') + '.js');
}