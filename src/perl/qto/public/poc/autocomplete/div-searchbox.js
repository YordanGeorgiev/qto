var Searchbox = {
  name: "searchbox",
  template: "#searchbox",
  props: {
    dblist: {
      type: Array,
      required: false,
      default: () => []
    },
    isAsync: {
      type: Boolean,
      required: false,
      default: false
    }
  }
  , model: {
	  prop: 'dblist',
	  event: 'dblistChange'
	},
	computed: {
		dblistLocal: {
			get: function() {
				return this.dblist
			},
			set: function(value) {
				dblist = value ; 
				this.$emit('dblistChange', value)
			}
		}
	}
  , data() {
    return {
      isOpen: false,
      results: [],
      searchQuery: "",
      isLoading: false,
      arrowCounter: 0
    };
  },
  methods: {
   onChange() {
      if ( !this.searchQuery.startsWith('in: ' ) ) {
         return ; 
      }
      this.$emit("input", this.searchQuery.replace('in: ' , ''));

      // Is the data given by an outside ajax request?
      if (this.isAsync) {
      	this.isLoading = true;
         this.filterResults();
      } else {
         this.filterResults();
         this.isOpen = true;
      }
    } 
    , filterResults() {
         this.results = this.dblist.filter(item => {
         var toSrch = this.searchQuery.toLowerCase().replace('in: ' , '')
         return item.toLowerCase().indexOf(toSrch) > -1;
      });
    }
    , setResult(result) {
         if ( typeof result !== 'undefined' ) {
            if ( result === 'in: undefined' ) {
               this.searchQuery = 'in: '
            } else {
               this.searchQuery = result;
            }
         }
         else {
            this.searchQuery = 'in: '
         }
         this.isOpen = false;
    }
    , onArrowDown(evt) {
         if (this.arrowCounter < this.results.length) {
            this.arrowCounter = this.arrowCounter + 1;
         }
    } 
    , onArrowUp() {
         if (this.arrowCounter > 0) {
            this.arrowCounter = this.arrowCounter - 1;
         }
    }
    , onArrowRight(e) {
         this.isOpen = false;
         this.setResult("in: " + this.results[this.arrowCounter])
    }
    , onArrowLeft(e) {
         this.isOpen = false;
         this.setResult("in: " + this.results[this.arrowCounter])
    }
    , onEnter() {
         this.isOpen = false;
         this.setResult("in: " + this.results[this.arrowCounter])
         window.alert("should I stay or should I go");
    }
    , handleClickOutside(e) {
         if (!this.$el.contains(e.target)) {
            this.isOpen = false;
            this.arrowCounter = -1;
         }
    }
  }
  , watch: {
    dblist: function(val, oldValue) {
      if (val.length !== oldValue.length) {  // actually compare them
        this.results = val;
        this.isLoading = false;
      }
    }
  }
  , mounted() {
    document.addEventListener("click", this.handleClickOutside);
  }
  , destroyed() {
    document.removeEventListener("click", this.handleClickOutside);
  }
};

// the parent
new Vue({
  el: "#div_searchbox",
  name: "srchboxContainer",
  components: {
    searchbox: Searchbox
  },
  data() {
      return {
         pdblist: []
      }
  }
  , methods: {
	fetchSSData: function (url_params) { // only data logic here !!!
		if ( typeof url_params === "undefined" ) { url_params = { as:"etable" } }

      return axios.get(("/dev_qto/select-databases") , { params: url_params } )
      .then(response => {
         return response.data.dat.map(obj => obj.datname);
      })
      .catch(function(error) {
         console.error ( error.toString );
         return error ; 
      })
	 }
  , fetchSSDataUI: function (url_params) { // only UI logic here !!!
      var self = this
      return this.fetchSSData()
      .then( response => {
         if ( response.toString().startsWith('Error') ) {  // NOK 
            self.pdblist = [] ; 
            window.alert(response.toString()) ; 
         }
         else {                                             // OK 
            self.pdblist = response ; 
         }
      })
      .catch(function(error) {                              // NOK
         self.pdblist = [] ; 
         window.alert(error.toString()) ; 
      })
   }
  }
  , mounted() {
      this.fetchSSDataUI() ; 
      document.addEventListener("click", this.handleClickOutside);
  }
});

