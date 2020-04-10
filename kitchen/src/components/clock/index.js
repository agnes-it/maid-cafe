import React, { useState } from 'react';

function tick(date) {
  return {
    hours: String(date.getHours()).padStart(2, '0'),
    minutes: String(date.getMinutes()).padStart(2, '0'),
    seconds: String(date.getSeconds()).padStart(2, '0')
  };
}

export default function Clock() {
  const [clock, setClock] = useState(tick(new Date));

  React.useEffect(() => {
    setTimeout(() => {
      setClock(tick(new Date));
    }, 100);
  }, [clock]);

  return (
    <h1>{clock.hours}:{clock.minutes}:{clock.seconds}</h1>
  );
}
