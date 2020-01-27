/** usage: 
	clear ; cd src/js/node/ppoc ; npm test ; cd - ;
*/
'use strict';
const puppeteer = require('puppeteer');
const path = require('path')

async function main(){
	try {
		const browser = await puppeteer.launch({headless: false});
		const page = await browser.newPage();
		await page.setViewport({width: 1200, height: 720})
		await testLogin(page)
		await testSearch(page)
		await testViewDoc(page)
		await testList(page)	
		await browser.close();
	} catch (error) {
	  console.log(error);
	  await browser.close();
	} finally {
	  await browser.close();
	}
}

async function testLogin(page) {
		await page.goto('http://host-name:8082/tst_qto/login', { waitUntil: 'networkidle0' }); // wait until
		await page.type('#email', 'test.anonymous.user@gmail.com');
		//await page.type('#pass', 'secret');
		await page.waitFor(1000);
		await Promise.all([
			page.click('#butLogin'),
			page.waitForNavigation({ waitUntil: 'networkidle0' }),
		]);
}

async function testSearch(page) {
	await page.type('#inp_srch_box', 'add');
	await page.type('#inp_srch_box',String.fromCharCode(13));
	await page.waitFor(1000);
}

async function testViewDoc(page) {
		await page.goto('http://host-name:8082/tst_qto/view/requirements_doc', { waitUntil: 'networkidle0' }); 
		await page.type('#inp_srch_box', 'add');
		await page.waitFor(1000);
		// nope const element = await page.$('[onclick="openRightMenu()"]');
		// nope await element.click();
}

async function testList(page) {
	await page.goto('http://host-name:8082/tst_qto/list/ideas', { waitUntil: 'networkidle0' }); 
	await page.waitFor(1000);
	await page.type('#inp_srch_box', 'add');
	await page.waitFor(1000);
}

function getProductInstanceDir(){
	return path.join(path.dirname(__filename), '../../../../../'); 
	
}

main();
