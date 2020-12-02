import * as data from './02.input.json';

interface PasswordStruct {
  letter: string
  text: string
  min: number
  max: number
}

const getMinMaxPasswords = (data: PasswordStruct[] = []) => {
  return data.filter(({ min, max, text, letter }) => {
    const count = text.match(new RegExp(letter, "g"))?.length
    return count >= min && count <= max
  }).length
}

const getPositionPasswords = (data: PasswordStruct[] = []) => {
  return data.filter(({ min, max, text, letter }) => {
    const hasFirst = text[min-1] === letter;
    const hasSecond = text[max-1] === letter;
    return hasFirst !== hasSecond
  }).length
}

console.log(getMinMaxPasswords(data as PasswordStruct[]));
console.log(getPositionPasswords(data));