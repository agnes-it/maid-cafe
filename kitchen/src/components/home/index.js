import React, { useState, useEffect } from 'react';
import ZeroState from '../zero-state';
import Card from '../card';
import { compose, pick } from '../../lib/functional';
import {getBills, finishBill} from '../../api';


export default function Home() {
  const [bills, setBills] = useState([]);

  const appliedSetBills = compose(setBills, pick('data'));

  const fetchBills = () => getBills().then(appliedSetBills).catch(console.error);
  const handleCloseBill = bill => finishBill(bill).then(fetchBills).catch(console.error);
  
  useEffect(() => {
    fetchBills();
  }, []);

  if (!bills.length) {
    return <ZeroState />;
  }

  return (
    <div>
        <h1>Bills</h1>
        <main>
          {bills.map((bill, index) => <Card key={index} bill={bill} onFinishBill={handleCloseBill} />)}
        </main>
      </div>
  );
}