import React from 'react';
import Clock from '../clock';
import style from './style.less';

export default class Header extends React.Component {
  render() {
    return (
      <header className={style.header}>
        <h1>Kitchen Panel</h1>
        <nav>
          <Clock />
        </nav>
      </header>
    );
  }
}
