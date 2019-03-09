// register the grid component
// register modal component
import VModal from '../../../node_modules/vue-js-modal/dist/index.js'
Vue.use(VModal)

var vue_js_modal = require('vue-js-modal');

// start app
new Vue({
   el: '#app_modal_dialog',
   data: () => ({
      showModal: false
  }),
   methods: {
      show () {
         this.$modal.show('hello-world');
      },
      hide () {
         this.$modal.hide('hello-world');
      }
   }
})
