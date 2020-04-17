import Header from './Header';
import Home from './Home';
import React, { useState } from "react";
import { hot } from 'react-hot-loader/root';
import { serverTime } from '../api';
import _ from 'lodash';

const App = () => {
  const [ serverTimeDiff, setTimeDiff ] = useState(null);
  
  serverTime().then((data) => {
    const localDate = new Date();
    const serverDate = _.get(data, 'server_date', new Date());
    const dateDiff = serverDate - localDate;
    setTimeDiff(dateDiff);
  });

  return (
    <React.Fragment>
      <Header deltaTime={serverTimeDiff} />
      <Home path="/" />
    </React.Fragment>
  );
}

export default hot(App);