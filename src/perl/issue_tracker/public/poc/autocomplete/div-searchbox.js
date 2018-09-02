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
      // Let's warn the parent that a change was made
      this.$emit("input", this.searchQuery.replace('in: ' , ''));
      // Is the data given by an outside ajax request?
      if (this.isAsync) {
      	this.isLoading = true;
         this.filterResults();
      } else {
        // Let's search our flat array
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
      this.searchQuery = result;
      this.isOpen = false;
      window.alert("should redirect to the following url: <<url>>");
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
    , onEnter() {
      this.searchQuery = 'in: ' + this.results[this.arrowCounter];
      this.isOpen = false;
      this.arrowCounter = -1;
    }
    , handleClickOutside(evt) {
      if (!this.$el.contains(evt.target)) {
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
	fetchSSData: function (url_params) {
		if ( typeof url_params === "undefined" ) { url_params = { as:"etable" } }

      return axios.get(("/dev_issue_tracker/select-databases") , { params: url_params } )
      .then(response => {
         return response.data.dat.map(obj => obj.datname);
      })
      .catch(function(error) {
         // todo:ysg
         console.log ( error.toString );
         return error ; 
      })
	 }
  }
  , mounted() {
      var self = this
      this.fetchSSData().then( data => {
         self.pdblist = data ; 
      })
      document.addEventListener("click", this.handleClickOutside);
  },
});

