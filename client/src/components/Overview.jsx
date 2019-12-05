import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { Row, Col } from 'react-bootstrap';
import { clientGet } from 'client';

class Overview extends Component {
  constructor(props) {
    super(props);
    this.state = {
      data: [],
      errorMessage: ''
    };
  }

  async componentDidMount() {
    const url = this.props.overviewDataUrl
    clientGet(url)
      .then(response => {
        this.setState({ data: response.data });
      })
      .catch(errorMessage => {
        this.setState({errorMessage: errorMessage})
      })
  }

  render() {
    return (
      <Row className="intake">
        <Col md>
          <h4>Einnahmen:&nbsp;
            <small className="text-muted">
              { this.state.data.intake }
            </small>
          </h4>
        </Col>
        <Col md>
          <h4>Ausgaben:&nbsp;
            <small className="text-muted">
              { this.state.data.outgoings }
            </small>
          </h4>
        </Col>
        <Col md>
          <h4>Differenz:&nbsp;
            <small className={(this.state.data.negative ? 'text-danger' : 'text-success')}>
              { this.state.data.difference }
            </small>
          </h4>
        </Col>
      </Row>
    )
  }
}

Overview.propTypes = {
  overviewDataUrl: PropTypes.string
};

Overview.defaultProps = {
  overviewDataUrl: ''
};

// export default props => <Overview {...props} />;

export default Overview;