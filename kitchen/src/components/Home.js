import React, { useState, useEffect } from 'react';
import ZeroState from './ZeroState';
import Card from './Card';
import GridList from './GridList';
import { compose, pick } from '../lib/functional';
import { polling } from '../lib/polling'
import {getBills, finishBill} from '../api';


export default function Home() {
  const [bills, setBills] = useState([]);

  const appliedSetBills = compose(setBills, pick('data'));

  const fetchBills = () => getBills().then(result => {
    appliedSetBills(result);
    return result;
  }).catch(console.error);
  const handleCloseBill = bill => finishBill(bill).then(fetchBills).catch(console.error);
  
  useEffect(() => {
    fetchBills();
    polling(fetchBills);
  }, []);

  if (!bills.length) {
    return <ZeroState />;
  }

  return (
    <main className="mt-8">
      <GridList
        chunkSize="4"
        list={bills}
        component={(bill, index) => <Card key={index} bill={bill} onFinishBill={handleCloseBill} />}
      />
    </main>
  );
}