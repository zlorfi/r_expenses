document.addEventListener('turbolinks:load', function() {
  if ( document.getElementById('expense_intake') ) {
    if ( document.getElementById('expense_intake').checked ) {
      document.getElementsByClassName('category_select')[0].style.display = 'none';
    }

    document.getElementById('expense_intake').onclick = function() {
      if ( this.checked ) {
        document.getElementsByClassName('category_select')[0].style.display = 'none';
      } else {
        document.getElementsByClassName('category_select')[0].style.display = 'block';
      }
    };
  }

  if ( document.getElementById('date_list') ) {
    document.getElementById('date_list').onchange = function() {
      this.form.submit();
    };
  }
});
