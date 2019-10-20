
var state = {
	items: []
 };

var getters = {
	getItems: state => state.items
}

 // where the state is mutated
 var mutations = {
        ADD_ITEM: (state, payload) => {
            var newItem = {
                id: payload.newId,
                name: payload.name,
                completed: false
            }
            state.items.unshift(newItem);
        },
        SET_ITEMS (state, items) {
            state.items = items
        },
        TOGGLE_ITEM: (state, payload) => {
            var item = state.items.find(todo => todo.id === payload);
            item.completed = !item.completed;
        },
        DELETE_TODO: (state, payload) => {
            var index = state.items.findIndex(todo => todo.id === payload);
            state.items.splice(index, 1);
        }
 };
   
   // where the backend calls are issued
   // Instead of mutating the state, actions commit mutations.
   // Actions can contain arbitrary asynchronous operations
   var actions = {
		loadItems ({ commit }) {
			axios
			.get('http://echo.jsontest.com/name/this-is-item-01-hit-enter-for-more')
			.then(r => r.data) // replace here ^^^ with your backend call
			.then(items => {
				commit('SET_ITEMS', Array(items))
			})
		  },
        addItem: (context, payload) => {
            var loadFromBackEnd = "nok"
            if ( loadFromBackEnd === 'ok' ) {
               context.commit("ADD_ITEM", payload)
            }
        },
        toggleItem: (context, payload) => {
            context.commit("TOGGLE_ITEM", payload)
        },
        deleteItem: (context, payload) => {
            context.commit("DELETE_TODO", payload)
        }
    }

 var store = new Vuex.Store({
        state: state,
        getters: getters,
        mutations: mutations,
        actions: actions
    });

 Vue.component("list-items", {
  		  created () {
    			this.$store.dispatch('loadItems')
  		  },
        computed: {
            items() {
                return this.$store.getters.getItems;
            }
        },
        methods: {
            toggleItem: function(id) {
                this.$store.dispatch("toggleItem", id);
            },
            deleteItem: function(id) {
                this.$store.dispatch("deleteItem", id);
            }
        },
        template: "#list-items"
    });
	
var app = new Vue({
        data: () => ({
            name: "",
            newId: 3
        }),
        methods: {
            addItem: function() {
                this.$store.dispatch("addItem", this);
                this.newId ++;
                this.name = "";
            }
        },
        store: store,
        el: "#app",
        template: "#app-template"
    });
	
