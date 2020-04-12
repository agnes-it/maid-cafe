import isEqual from 'lodash.isequal';

const DEFAULT_TIMEOUT = 5000;

let oldResult = null;
let equalsCount = 1;

export const polling = (fn, timeout = DEFAULT_TIMEOUT) => setTimeout(
    () => {
        fn().then(({ data: result }) => {
            let newTimeout = timeout;
            if (isEqual(oldResult, result)) {
                if (equalsCount < 4) {
                    newTimeout = timeout * equalsCount;
                    equalsCount++;
                }
            } else {
                newTimeout = DEFAULT_TIMEOUT;
                equalsCount = 1;
            }

            oldResult = result;
            polling(fn, newTimeout);
        });
    }, timeout);