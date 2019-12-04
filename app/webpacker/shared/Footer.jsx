import React from 'react';

class Footer extends React.Component {
  render() {
    return(
      <footer className="footer">
        <p>
          © skrynski.de {(new Date()).getFullYear()}
        </p>
      </footer>
    )
  }
}

export default Footer;
