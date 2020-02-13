/**
 * usage:
   cd src/js/node/ppoc/ ; npm install puppeteer; cd -
   cd src/js/node/ppoc/ ; npm run ; cd -
   cd src/js/node/ppoc/ ; node test-open-login.js; cd -
   cd src/js/node/ppoc/ ; npm test; cd -
 * @name open the login page
 *
 * @desc Gets the value of commonly used HTML form elements using page.$eval()
 * chk also:
 * src/js/node/ppoc/package.json
 *
 */
const puppeteer = require('puppeteer');
const { expect } = require('chai');
const _ = require('lodash');
const globalVariables = _.pick(global, ['browser', 'expect']);

// puppeteer options
const opts = {
  headless: false,
  slowMo: 100,
  timeout: 10000
};

// expose variables
before (async function () {
  global.expect = expect;
  global.browser = await puppeteer.launch(opts);
});

// close browser and reset global variables
after (function () {
  browser.close();

  global.browser = globalVariables.browser;
  global.expect = globalVariables.expect;
});

describe('sample test', function () {
  it('should work', async function () {
    console.log(await browser.version());

    expect(true).to.be.true;
  });


});
