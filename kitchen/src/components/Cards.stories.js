import React from 'react';
import Wrapper from '../../stories/Wrapper';
import Card from './Card';
import "../styles.less";

const request = {
    "id": 1,
    "maid": "neto",
    "client": "Snotr senpai",
    "table": "mesa 2",
    "start_at": new Date(),
    "end_at": null,
    "menu": [
        "filezinho a parmegianinha"
    ],
    "finish": false,
    "additional_info": ""
};

export const simpleCard = () => (
    <Wrapper maxWidth="sm">
        <Card bill={request} />
    </Wrapper>
);

export const finishedCard = () => (
    <Wrapper maxWidth="sm">
        <Card bill={{ ...request, finish: true }} />
    </Wrapper>
);

export default { title: 'Card' };