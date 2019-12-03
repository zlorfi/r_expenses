$(document).on('turbolinks:load', function() {
  if ($('#expense_intake').prop('checked')) {
    $('.category_select').hide();
  }

  $('#expense_intake').change(function() {
    if ($(this).prop('checked')) {
      $('.category_select').hide();
    } else {
      $('.category_select').show();
    }
  });

  return $('#date_list').on('change', function(e) {
    this.form.submit();
  });
});
