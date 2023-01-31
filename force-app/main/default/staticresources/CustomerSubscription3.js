"use strict";

function asyncGeneratorStep(gen, resolve, reject, _next, _throw, key, arg) { try { var info = gen[key](arg); var value = info.value; } catch (error) { reject(error); return; } if (info.done) { resolve(value); } else { Promise.resolve(value).then(_next, _throw); } }

function _asyncToGenerator(fn) { return function () { var self = this, args = arguments; return new Promise(function (resolve, reject) { var gen = fn.apply(self, args); function _next(value) { asyncGeneratorStep(gen, resolve, reject, _next, _throw, "next", value); } function _throw(err) { asyncGeneratorStep(gen, resolve, reject, _next, _throw, "throw", err); } _next(undefined); }); }; }

console.log('Test Begins');
window.com.test = {
  testAsyncLWC: function () {
    var _ref = _asyncToGenerator(function* () {
      yield 0; // Comment this out and the next line will display in console.

      console.log('testAsyncLWC complete');
    });

    return function testAsyncLWC() {
      return _ref.apply(this, arguments);
    };
  }()
};
console.log('Test Executing');
window.com.test.testAsyncLWC();