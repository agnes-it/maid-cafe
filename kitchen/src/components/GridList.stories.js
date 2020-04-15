import React from 'react';
import Wrapper from '../../stories/Wrapper';
import GridList from './GridList';
import Card from './Card';
import "../styles.less";

const requests = [
    {
        "id": 1,
        "maid": "neto",
        "client": "Brabo",
        "table": "mesa 1516",
        "start_at": "2020-04-15T22:35:42.108339Z",
        "end_at": null,
        "menu": [
            "bora"
        ],
        "finish": false,
        "additional_info": ""
    },
    {
        "id": 2,
        "maid": "neto2",
        "client": "Pirado",
        "table": "mesa 3",
        "start_at": "2020-04-15T22:35:42.108339Z",
        "end_at": null,
        "menu": [
            "bora"
        ],
        "finish": false,
        "additional_info": ""
    },
    {
        "id": 3,
        "maid": "neto21",
        "client": "Decente",
        "table": "mesa 2",    
        "start_at": "2020-04-15T22:35:42.108339Z",
        "end_at": null,
        "menu": [
            "bora"
        ],
        "finish": false,
        "additional_info": ""
    },
    {
        "id": 4,
        "maid": "neto22",
        "client": "Calmo",
        "table": "mesa 666",
        "start_at": "2020-04-15T22:35:42.108339Z",
        "end_at": null,
        "menu": [
            "bora"
        ],
        "finish": false,
        "additional_info": ""
    }
];

export const gridSize4 = () => (
    <Wrapper>
        <GridList
            chunkSize="4"
            list={requests}
            component={(bill, index) => <Card key={index} bill={bill} onFinishBill={() => console.log(`finished ${bill.id}`)} />}
          />
    </Wrapper>
);

export const gridSize2 = () => (
    <Wrapper>
        <GridList
            chunkSize="2"
            list={requests}
            component={(bill, index) => <Card key={index} bill={bill} onFinishBill={() => console.log(`finished ${bill.id}`)} />}
          />
    </Wrapper>
);

export default { title: 'GridList' }