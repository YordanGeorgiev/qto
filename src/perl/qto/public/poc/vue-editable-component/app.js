// src: https://stackoverflow.com/a/47181562/65706
Vue.component('editable', {
  template: `
    <div v-bind:id="id" contenteditable="true" @blur="emitChange">
      {{ content }}
    </div>
  `,
  props: ['content','id'],
  methods: {
    emitChange (ev) {
      this.$emit('update', ev.target.textContent,ev.target.id)
    }
  }
})

new Vue({
  el: '#app',
  data: {
    herobanner: {
      headline: 'Parent is updated on blur event, so click outside this text to update it.'
		, id: "12"
    }
  },
  methods: {
    async loadJson () {
      var response = await fetch('https://swapi.co/api/people/1')
      var hero = await response.json()
      this.herobanner.headline = hero.name
    },
    updateHeadline (content,id) {
      this.herobanner.headline = content
		console.log ( "new content: " + content ) 
		console.log ( "with id: " + id )
    }
  }
})
