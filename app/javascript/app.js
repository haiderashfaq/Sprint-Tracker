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
    checked ? $(".add-issues").prop("disabled", false) : $(".add-issues").prop("disabled", true)
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

  $('#menu-btn').on('click', function() {
    $('#sidebar').toggleClass("active");
  });
    // $(".nav .nav-link").on("click", function(){
    // $(".nav").find(".active").removeClass("active");
    // $(this).addClass("active");
    // });

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

var dateTimeFunc = function() {
  $(".js-flatpickr-datetime").flatpickr({
    enableTime: true
  });
}