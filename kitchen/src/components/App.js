import Header from './header';
import Home from './home';
import React from "react";
import { hot } from 'react-hot-loader/root';

class App extends React.Component {
  render() {
    return (
      <React.Fragment>
        <Header />
        <Home path="/" />
      </React.Fragment>
    )
  }
}

export default hot(App);