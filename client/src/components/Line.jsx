import React, { Component } from 'react';
import 'shared/charts'
import * as d3 from 'd3';
import c3 from 'c3';
import PropTypes from 'prop-types';

class Line extends Component {
  constructor(props) {
    super(props);
  }

  async componentDidMount() {
    c3.generate({
      bindto: '#year_categories',
      data: {
        x: 'months_line',
        url: this.props.lineDataUrl,
        mimeType: 'json',
      },
      point: {
        show: true
      },
      color: {
        pattern: ['#1f77b4', '#aec7e8', '#ff7f0e', '#ffbb78', '#2ca02c', '#98df8a', '#d62728', '#ff9896', '#9467bd', '#c5b0d5', '#8c564b', '#c49c94', '#e377c2', '#f7b6d2', '#7f7f7f', '#c7c7c7', '#bcbd22', '#dbdb8d', '#17becf', '#9edae5']
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
  }

  render() {
    return(
      <div id="year_categories">
        <div className="chart">
          <div className="loading">Loading...</div>
        </div>
      </div>
    )
  }
}

Line.propTypes = {
  lineDataUrl: PropTypes.string
};

export default Line;