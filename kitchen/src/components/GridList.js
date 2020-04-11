import React from 'react';

function chunk (arr, len) {
    var chunks = [],
        i = 0,
        n = arr.length;
    while (i < n) {
      chunks.push(arr.slice(i, i += len));
    }
    return chunks;
}

export default function GridList({ list, component, chunkSize }) {
    const listSplit = chunk(list, chunkSize);

    return listSplit.map(list => (
        <div className="flex mb-4">
            {list.map((item, index) => (
                <div className={`w-1/${chunkSize} px-2`}>
                    {component(item, index)}
                </div>
            ))}
        </div>
    ));
}