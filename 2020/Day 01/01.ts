import * as data from './01.input.json';

const getSum = (value: number, data: number[] = [], count = 2) => {
  for (const item of data) {
    const sub = data.filter((i) => i <= (value - item))
    const acc = count > 2 ? getSum(value - item, sub, count - 1) : sub[sub.indexOf(value - item)]
    if (acc) return acc * item
  }
}

const sortedData = data.sort((a,b) => a - b);
console.log(getSum(2020, sortedData));
console.log(getSum(2020, sortedData, 3));