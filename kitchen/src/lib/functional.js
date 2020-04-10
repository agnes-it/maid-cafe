export const compose = (...functions) => args => functions.reduceRight((arg, fn) => fn(arg), args);
export const pick = (key) => result => result[key];