import React from 'react';
import PropTypes from 'prop-types';


export default function Card({ bill, onFinishBill }) {
    return (
        <li>
            <div>
            <h3>
                Table: {bill.table}
            </h3>
            <small>
                Start at: {(new Date(bill.start_bill)).toLocaleTimeString()}
            </small>
            <a onClick={() => onFinishBill(bill)}>Finish</a>
            </div>
            <div>
            <span>{bill.menu.join(', ')}</span>
            {bill.additional_info
                ? <p>
                    Info: {bill.additional_info}
                </p>
                : null}
            </div>
        </li>
    );
};

Card.propTypes = {
    bill: PropTypes.object,
    onFinishBill: PropTypes.func
};

Card.defaultProps = {};