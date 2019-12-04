import ReactOnRails from 'react-on-rails';
import '../src/expenses_jquery.js';
import 'bootstrap/dist/js/bootstrap';

import Footer from '../shared/Footer';
import Donut from '../src/Donut';
import Line from '../src/Line';
import Bar from '../src/Bar';
import Overview from '../src/Overview';

require("@rails/ujs").start();
require("turbolinks").start();
require.context('../images', true);

ReactOnRails.register({
  Footer,
  Donut,
  Line,
  Overview,
  Bar
});
