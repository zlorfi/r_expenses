$(document).ready ->
  $('#expense_intake').change ->
    if $(this).prop('checked')
      $('.category_select').hide()
    else
      $('.category_select').show()
    return
