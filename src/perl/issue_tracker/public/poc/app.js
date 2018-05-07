const vm = new Vue({
  el: '#app',
  data: {
    monthly_issues: []
  },
  mounted() {
    axios.get("/dev_issue_tracker/list/monthly_issues")
    .then(response => {this.monthly_issues = response.data.dat
	 })
  }
	
});
