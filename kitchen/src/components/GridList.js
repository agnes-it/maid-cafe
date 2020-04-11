import React from 'react';


export default function GridList({ list, component, chunkSize }) {
    return (
        <div className="flex flex-wrap">
            {list.map((item, index) => (
                <div className={`w-full sm:w-1/2 md:w-1/${chunkSize/2} lg:w-1/${chunkSize} mb-4 px-2`}>
                    {component(item,index)}
                </div>
            ))}
        </div>
    );
}