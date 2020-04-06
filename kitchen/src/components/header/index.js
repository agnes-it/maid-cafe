import React from 'react';
import Clock from '../clock';
import './style.less';

export default class Header extends React.Component {
  render() {
    return (
      <header>
        <h1>Kitchen Panel</h1>
        <nav>
          <Clock />
        </nav>
      </header>
    );
  }
}
