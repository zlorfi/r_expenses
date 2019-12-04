import React from 'react';
import '../shared/charts.js'
import * as d3 from 'd3';
import c3 from 'c3';
import PropTypes from 'prop-types';

class Donut extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      data: {}
    }
  }

  componentDidMount() {
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
  }

  render() {
    return(
      <div id="expense_given_month">
        <div className="chart">
          <div className="loading">Loading...</div>
        </div>
      </div>
    )
  }
}

Donut.propTypes = {
  dataUrl: PropTypes.string
};

export default Donut;