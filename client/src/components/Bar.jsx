import React, { Component } from 'react';
import 'shared/charts.js'
import * as d3 from 'd3';
import c3 from 'c3';
import PropTypes from 'prop-types';

class Bar extends Component {
  constructor(props) {
    super(props);
  }

  async componentDidMount() {
    c3.generate({
      bindto: '#year_sums',
      data: {
        x: 'months_bar',
        url: this.props.barDataUrl,
        mimeType: 'json',
        type: 'bar'
      },
      color: {
        pattern: ['#dc3545', '#28a745']
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
  }

  render() {
    return(
      <div id="year_sums">
        <div className="chart">
          <div className="loading">Loading...</div>
        </div>
      </div>
    )
  }
}

Bar.propTypes = {
  barDataUrl: PropTypes.string
};

export default Bar;