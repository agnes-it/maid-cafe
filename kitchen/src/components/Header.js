import React from 'react';
import PropTypes from 'prop-types';
import Clock from './Clock';


export default function Header({ title }) {
  return (
    <header className="bg-purple-500 flex justify-between p-6 text-white text-xl font-bold">
      <h1 className="bg-transparent text-white items-center">{title}</h1>
      <nav>
        <Clock />
      </nav>
    </header>
  );
}

Header.propTypes = {
  title: PropTypes.string
};

Header.defaultProps = {
  title: "Kitchen Panel"
};