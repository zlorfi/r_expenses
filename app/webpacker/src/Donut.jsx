import '../shared/charts.js'
import * as d3 from 'd3';
import c3 from 'c3';
import PropTypes from 'prop-types';

const Donut = props => (
  document.addEventListener('turbolinks:load', function() {
    var donut = c3.generate({
      size: {
        height: 400
      },
      bindto: '#expense_given_month',
      data: {
        url: props.dataUrl,
        mimeType: 'json',
        type: 'donut',
      },
      tooltip: {
        format: {
          value: function(value, ratio, id) {
            return d3.format('$,.2f')(value);
          }
        }
      }
    })

    return donut;
  })
);

Donut.propTypes = {
  dataUrl: PropTypes.string
};

export default Donut;