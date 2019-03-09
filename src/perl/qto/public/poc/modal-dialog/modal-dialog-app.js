// register the grid component
// register modal component
Vue.component('modal', {
  template: '#modal-template'
})

// start app
new Vue({
  el: '#app_modal_dialog',
  data: () => ({
    showModal: false
  }),
  watch: {
    showModal() {
      const handler = e => {
        if (e.keyCode === 27) {
          this.dialog = false
          window.removeEventListener('keydown', handler)
        }
      }
      if (this.dialog) {
        window.addEventListener('keydown', handler)
      }
    }
  }
})
