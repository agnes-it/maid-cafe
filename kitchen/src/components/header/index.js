import React from 'react';
import Clock from '../clock';
export default class Header extends React.Component {
  render() {
    return (
      <header className={"bg-purple flex justify-between p-6"}>
        <h1 className="bg-transparent text-black items-center">Kitchen Panel</h1>
        <nav>
          <Clock />
        </nav>
      </header>
    );
  }
}
