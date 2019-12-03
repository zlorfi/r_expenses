import '../src/expenses_jquery.js';
import 'bootstrap/dist/js/bootstrap';

$(function () {
  console.log('Hello World from Webpacker');
});

require("@rails/ujs").start();
require("turbolinks").start();
require.context('../images', true);