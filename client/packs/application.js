import ReactOnRails from 'react-on-rails';
import 'expenses_jquery.js';
import Turbolinks from 'turbolinks';
import Rails from '@rails/ujs';
import 'bootstrap/dist/js/bootstrap';
import Footer from '../src/components/Footer';
import Overview from 'components/Overview';
import Donut from 'components/Donut';
import Line from 'components/Line';
import Bar from 'components/Bar';

Rails.start();
Turbolinks.start();
require.context('../images', true);

ReactOnRails.register({
  Footer,
  Overview,
  Donut,
  Line,
  Bar
});