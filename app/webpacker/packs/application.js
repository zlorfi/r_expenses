import '../src/expenses_jquery.js';
import 'bootstrap/dist/js/bootstrap';
import ReactOnRails from 'react-on-rails';

import Footer from '../shared/Footer';
import Donut from '../src/Donut';
import Line from '../src/Line';
import Bar from '../src/Bar';

require("@rails/ujs").start();
require("turbolinks").start();
require.context('../images', true);

ReactOnRails.register({
  Footer,
  Donut,
  Line,
  Bar
});
