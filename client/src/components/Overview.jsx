import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { Row, Col } from 'react-bootstrap';
import { clientGet } from '../client';
// import axios from 'axios';

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
      // axios.get(props.overviewDataUrl)
      // .then(res => {
      //   const data = res.data;
      //   this.setState({ data });
      // })
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

Overview.defaultProps = {
  overviewDataUrl: ''
};

// export default props => <Overview {...props} />;

export default Overview;