import React from 'react';
import PropTypes from 'prop-types';
import defaultImage from '../assets/food.jpg';


export default function Card({ bill, onFinishBill }) {
    return (
        <div className="max-w-sm w-full lg:max-w-full lg:flex">
            <div
                className="lg:h-a0uto lg:w-32 flex-none bg-cover rounded-t lg:rounded-t-none lg:rounded-l text-center overflow-hidden"
                style={{
                    backgroundSize: 'contain',
                    backgroundImage: `url(${defaultImage})`
                }}
                title="Food"
            >
            </div>
            <div
                className="w-full lg:max-w-full border-r border-b border-l border-gray-400 lg:border-l-0 lg:border-t lg:border-gray-400 bg-white rounded-b lg:rounded-b-none lg:rounded-r p-4 flex flex-col justify-between leading-normal"
            >
                <div className="mb-8">
                    <div className="text-gray-900 font-bold text-xl mb-2">
                        {bill.menu.join(', ')}
                    </div>
                    <p className="text-gray-700 text-base">
                        {bill.additional_info
                            ? `Info: ${bill.additional_info}`
                            : 'Complete'}
                    </p>
                </div>
                <div className="flex items-center">
                    <div className="text-sm">
                        <p className="text-gray-900 leading-none">Table: {bill.table}</p>
                        <p className="text-gray-600">Start at: {(new Date(bill.start_bill)).toLocaleTimeString()}</p>
                    </div>
                </div>
                <button
                    className="bg-transparent hover:bg-blue-500 text-blue-700 font-semibold hover:text-white py-2 px-4 border border-blue-500 hover:border-transparent rounded"
                    onClick={() => onFinishBill(bill)}>
                        Finish
                </button>
            </div>
        </div>
    );
};

Card.propTypes = {
    bill: PropTypes.object.isRequired,
    onFinishBill: PropTypes.func.isRequired
};

Card.defaultProps = {};