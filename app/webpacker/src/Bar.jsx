import '../shared/charts.js'
import * as d3 from 'd3';
import c3 from 'c3';
import PropTypes from 'prop-types';

const Bar = props => (
  document.addEventListener('turbolinks:load', function() {
    var bar = c3.generate({
      bindto: '#year_sums',
      data: {
        x: 'months_bar',
        url: props.dataUrl,
        mimeType: 'json',
        type: 'bar'
      },
      axis: {
        x: {
          type: 'timeseries',
          tick: {
            format: d3.timeFormat('%B %Y')
          }
        },
        y: {
          tick: {
            format: d3.format("$,.2f")
          }
        }
      }
    })

    return bar;
  })
);

Bar.propTypes = {
  dataUrl: PropTypes.string
};

export default Bar;