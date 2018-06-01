const vm = new Vue({
  el: '#app',
  data: {
    monthly_issues: []
  },
  mounted() {
    axios.get("/tst_issue_tracker/select/monthly_issues")
    .then(response => {this.monthly_issues = response.data.dat
	 })
  }
	
});
