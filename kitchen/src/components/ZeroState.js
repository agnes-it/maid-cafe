import React from 'react';
import PropTypes from 'prop-types';


export default function ZeroState({ message }) {
    return (
        <div className="m-10 flex p-6 bg-gray-300">
          <h1>{message}</h1>
        </div>
    );
}


ZeroState.propTypes = {
  message: PropTypes.string
};

ZeroState.defaultProps = {
  message: "No bills yet. Maybe we can take a breath."
};