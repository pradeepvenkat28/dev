"use strict";

console.log('Test Begins');
window.com.test = {
  testAsyncLWC: async function () {
    await 0; // Comment this out and the next line will display in console.

    console.log('testAsyncLWC complete');
  }
};
console.log('Test Executing');
window.com.test.testAsyncLWC();