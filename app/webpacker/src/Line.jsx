import * as d3 from 'd3';
import c3 from 'c3';
import PropTypes from 'prop-types';
import '../shared/charts.js'

const Line = props => (
  document.addEventListener('turbolinks:load', function() {
    var line = c3.generate({
      bindto: '#year_categories',
      data: {
        x: 'months_line',
        url: props.dataUrl,
        mimeType: 'json',
      },
      axis: {
        x: {
          type: 'timeseries',
          tick: {
            format: d3.timeFormat('%B %Y')
          }
        },
        y: {
          min: 10,
          tick: {
            format: d3.format("$,.2f")
          }
        }
      }
    })

    return line;
  })
);

Line.propTypes = {
  dataUrl: PropTypes.string
};

export default Line;