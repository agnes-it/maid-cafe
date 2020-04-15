import React from 'react';

export default function Wrapper({ maxWidth, children }) {
    return (
        <div className={`max-w-${maxWidth} p-10`}>
            {children}
        </div>
    )
}