// file: scrap-html.js src: https://gist.github.com/magician11/a979906401591440bd6140bd14260578
const CDP = require('chrome-remote-interface');
const chromeLauncher = require('chrome-launcher');

(async function() {
  const launchChrome = () =>
    chromeLauncher.launch({ chromeFlags: ['--disable-gpu', '--headless'] });

  const chrome = await launchChrome();
  const protocol = await CDP({ port: chrome.port });
  const timeout = ms => new Promise(resolve => setTimeout(resolve, ms));

  // See API docs: https://chromedevtools.github.io/devtools-protocol/
  const { Page, Runtime, DOM } = protocol;
  await Promise.all([Page.enable(), Runtime.enable(), DOM.enable()]);

  // ok uri = 'http://qto.fi:8080/qto/view/readme_doc'
  uri = process.argv[2]
  // uri = 'https://qto.fi/qto/view/readme_doc'
  // uri = 'http://host-name:8082/tst_kone/list/requirements_doc?&pg-size=100&pick=name,formats'
  console.log ( uri )
  Page.navigate({ url: uri });

  // wait until the page says it's loaded...
  Page.loadEventFired(async () => {
    try {
      await timeout(4000); // give the JS some time to load

      // get the page source
      const rootNode = await DOM.getDocument({ depth: -1 });
      const pageSource = await DOM.getOuterHTML({
        nodeId: rootNode.root.nodeId
      });
      protocol.close();
      chrome.kill();
      console.log ( pageSource.outerHTML)
    } catch (err) {
      console.log(err);
    }
  });
})();
//eof file: scrap-html.js
