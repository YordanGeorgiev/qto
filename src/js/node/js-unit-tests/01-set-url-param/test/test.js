// usage: clear ; cd src/js/node/js-unit-tests/01-set-url-param ; npm test ; cd -
// prereqs: , nodejs , mocha
// URI = scheme:[//authority]path[?paramName1=paramValue1&paramName2=paramValue2][#fragment]
// call by: uri = uri.setUriParam("as","md")
String.prototype.setUriParam = function (paramName, paramValue) {
   var uri = this
   var fragment = ( uri.indexOf('#') === -1 ) ? '' : uri.split('#')[1] 
   uri = ( uri.indexOf('#') === -1 ) ? uri : uri.split('#')[0] 
   if ( uri.indexOf("?") === -1 ) { uri = uri + '?&' } 
   uri = ( uri.indexOf(paramName + '=') === -1 ) ? (uri + paramName + "=" + String(paramValue)):uri
   uri = uri.replace ( '?' + paramName , '?&' + paramName)
   var toRepl = (paramValue != null) ? toRepl = '$1' + paramValue : ''
   var toSrch = new RegExp('([&]' + paramName + '=)([^&#].*?)')
   uri = uri.replace(toSrch,toRepl)
   uri = ( fragment.length == 0 ) ? uri : (uri+"#"+fragment) //may-be re-add the fragment 
   return uri
}

var assert = require('assert');
describe('replacing url param value', function () {
   
   // scheme://authority/path[?p1=v1&p2=v2#fragment
   it('http://org.com/path?prm=src_v -> http://org.com/path?&prm=tgt_v', function (){
      var uri = 'http://site.eu:80/qto/view/devops_guide_doc?bid=5'
      var uriExpected = 'http://site.eu:80/qto/view/devops_guide_doc?&bid=10'
      var uriActual = uri.setUriParam("bid",10)
      assert.equal(uriActual, uriExpected);
   });

   it('http://org.com/path?&prm=src_v -> http://org.com/path?&prm=tgt_v', function (){
      var uri = 'http://site.eu:80/qto/view/devops_guide_doc?&bid=5'
      var uriExpected = 'http://site.eu:80/qto/view/devops_guide_doc?&bid=10'
      var uriActual = uri.setUriParam("bid",10)
      assert.equal(uriActual, uriExpected);
   });
   
   it('http://org.com/path?prm=src_v&other_p=other_v -> http://org.com/path?&prm=tgt_v&other_p=other_v', function (){
      var uri = 'http://site.eu:80/qto/view/devops_guide_doc?bid=5&other_p=other_v'
      var uriExpected = 'http://site.eu:80/qto/view/devops_guide_doc?&bid=10&other_p=other_v'
      var uriActual = uri.setUriParam("bid",10)
      assert.equal(uriActual, uriExpected);
   });

   it('http://org.com/path?&prm=src_v&other_p=other_v -> http://org.com/path?&prm=tgt_v&other_p=other_v', function (){
      var uri = 'http://site.eu:80/qto/view/devops_guide_doc?&bid=5&other_p&other_v'
      var uriExpected = 'http://site.eu:80/qto/view/devops_guide_doc?&bid=10&other_p&other_v'
      var uriActual = uri.setUriParam("bid",10)
      assert.equal(uriActual, uriExpected);
   });

   // with fragment
   it('http://org.com/path?prm=src_v&other_p=other_v#f -> http://org.com/path?&prm=tgt_v&other_p=other_v#f', function (){
      var uri = 'http://site.eu:80/qto/view/devops_guide_doc?bid=5&other_p=other_v#f'
      var uriExpected = 'http://site.eu:80/qto/view/devops_guide_doc?&bid=10&other_p=other_v#f'
      var uriActual = uri.setUriParam("bid",10)
      assert.equal(uriActual, uriExpected);
   });

   it('http://org.com/path?&prm=src_v&other_p=other_v#f -> http://org.com/path?&prm=tgt_v&other_p=other_v#f', function (){
      var uri = 'http://site.eu:80/qto/view/devops_guide_doc?&bid=5&other_p&other_v#f'
      var uriExpected = 'http://site.eu:80/qto/view/devops_guide_doc?&bid=10&other_p&other_v#f'
      var uriActual = uri.setUriParam("bid",10)
      assert.equal(uriActual, uriExpected);
   });

   // remove the param-name , param-value pair
   it('http://org.com/path?prm=src_v&other_p=other_v#f -> http://org.com/path?&prm=tgt_v&other_p=other_v#f', function (){
      var uri = 'http://site.eu:80/qto/view/devops_guide_doc?bid=5&other_p=other_v#f'
      var uriExpected = 'http://site.eu:80/qto/view/devops_guide_doc?&other_p=other_v#f'
      var uriActual = uri.setUriParam("bid",null)
      assert.equal(uriActual, uriExpected);
   });

   it('http://org.com/path?&prm=src_v&other_p=other_v#f -> http://org.com/path?&prm=tgt_v&other_p=other_v#f', function (){
      var uri = 'http://site.eu:80/qto/view/devops_guide_doc?&bid=5&other_p&other_v#f'
      var uriExpected = 'http://site.eu:80/qto/view/devops_guide_doc?&other_p&other_v#f'
      var uriActual = uri.setUriParam("bid",null)
      assert.equal(uriActual, uriExpected);
   });
   
 
});
// todo:require('./lib/file1.js');
