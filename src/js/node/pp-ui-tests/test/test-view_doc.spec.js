/** usage: 
	clear ; cd src/js/node/pp-ui-tests ; npm test ; cd - ;
*/
'use strict';
const puppeteer = require('puppeteer');
const path = require('path')

async function main(){
	const browser = await puppeteer.launch({headless: false});
	try {
		var ConfFile = getProductInstanceDir() + "cnf/env/dev.env.json";
		var json = require(ConfFile);
		const page = await browser.newPage();
		await page.setViewport({width: 1200, height: 720})
		await testLogin(json.env, page);
		await testViewDoc(json.env,page)
	} catch (error) {
	  console.log(error);
	} finally {
	  await browser.close();
	}
}

async function testLogin(env,page) {
		var url = env.app.ht_protocol + '://' + env.app.web_host + ':' + env.app.mojo_morbo_port + '/qto/login';
		await page.goto(url, { waitUntil: 'networkidle0' }); // wait until
		await page.type('#email', 'test.anonymous.user@gmail.com');
		//await page.type('#pass', 'secret');
		await page.waitFor(1000);
		await Promise.all([
			page.click('#butLogin'),
			page.waitForNavigation({ waitUntil: 'networkidle0' }),
		]);
}


async function testViewDoc(env,page) {
		var uri = env.app.ht_protocol + '://' + env.app.web_host + ':' + env.app.mojo_morbo_port + '/qto/view/test_hierarchy_doc';
		await page.goto(uri, { waitUntil: 'networkidle0' }); 
		//await page.type('#inp_srch_box', 'name-01'); //test quick search
		await page.waitFor(1000);
		page.click('#div_open_rgt_menu'); //test thie open right menu action
		await page.waitFor(1000);
		await page.$$eval('a.cls-context-menu-link', elHandles => elHandles.forEach(el => el.click()))
		//nopeawait page.$$eval('a.cls-context-menu-link', elHandles => elHandles.forEach(el => el.click({button: 'right',delay: 1000,})))

		// todo:right click the test_hierarchy_doc-8
		page.click('#div_open_rgt_menu'); //test the close right menu action
		page.waitFor(1000);
		await page.waitFor(3000);
}


function getProductInstanceDir(){
	return path.join(path.dirname(__filename), '../../../../../'); 
	
}

describe('view doc page tests', function () {
  it(`should 
			- open the login page, login
			- open the view-doc page, 
			- open the right menu
			- click on all the num order links
			- close the right menu`
			, async function () {
      main();
  });
});

function sleep(ms) {
    return new Promise(resolve => setTimeout(resolve, ms));
}
