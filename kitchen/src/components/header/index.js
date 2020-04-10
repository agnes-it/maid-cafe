import React from 'react';
import Clock from '../clock';
export default class Header extends React.Component {
  render() {
    return (
      <header className={"bg-purple-500 flex justify-between p-6 text-white text-xl font-bold"}>
        <h1 className="bg-transparent text-white items-center">Kitchen Panel</h1>
        <nav>
          <Clock />
        </nav>
      </header>
    );
  }
}
