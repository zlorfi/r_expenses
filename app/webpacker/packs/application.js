import '../src/expenses_jquery.js';
import 'bootstrap/dist/js/bootstrap';
import ReactOnRails from 'react-on-rails';

import Footer from '../shared/Footer';

require("@rails/ujs").start();
require("turbolinks").start();
require.context('../images', true);

ReactOnRails.register({
  Footer
});
