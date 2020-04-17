import React, { useState, useEffect } from 'react';


function tick(dateStr) {
  const date = new Date(dateStr); 
  return {
    hours: String(date.getHours()).padStart(2, '0'),
    minutes: String(date.getMinutes()).padStart(2, '0'),
    seconds: String(date.getSeconds()).padStart(2, '0')
  };
}

export default function Clock(props) {
  const rightDate = new Date() + props.deltaTime;
  const [ clock, setClock ] = useState(tick(rightDate));

  useEffect(() => {
    setTimeout(() => {
      setClock(tick(rightDate));
    }, 100);
  }, [clock]);

  return (
    <h1>{clock.hours}:{clock.minutes}:{clock.seconds}</h1>
  );
}
