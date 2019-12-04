import React from 'react';
import PropTypes from 'prop-types';
import { Row, Col } from 'react-bootstrap';
import axios from 'axios';

class Overview extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      data: {}
    };
  }

  componentDidMount() {
    axios.get(props.overviewDataUrl)
      .then(res => {
        const data = res.data;
        this.setState({ data });
      })
  }

  render() {
    return (
      <Row className="intake">
        <Col md>
          <h3>Einnahmen:
            <small className="text-muted">
              { this.state.data.intake }
            </small>
          </h3>
        </Col>
        <Col md>
          <h3>Ausgaben:
            <small className="text-muted">
              { this.state.data.outgoings }
            </small>
          </h3>
        </Col>
        <Col md>
          <h3>Differenz:
            <small className="text-muted">
              { this.state.data.difference }
            </small>
          </h3>
        </Col>
      </Row>
    )
  }
}

Overview.propTypes = {
  overviewDataUrl: PropTypes.string
};

export default Overview;