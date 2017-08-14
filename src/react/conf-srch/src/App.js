import React, { Component } from 'react';
import './App.css';
import Autosuggest from 'react-autosuggest';
import axios from 'axios' ; 

var list_items = [
  {
    name: 'C',
    guid: 1972
  }
]; 


function escapeRegexCharacters(str) {
  return str.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
}

function getSuggestions(value) {
  const escapedValue = escapeRegexCharacters(value.trim());
  
  if (escapedValue === '') {
    return [];
  }

   // ignore case , match contains any
   const regex = new RegExp('^.*' + escapedValue + '.*' , 'i');

	// console.log ( "getSuggestions" ) 
   // console.log ( list_items ) 
   // console.log ( regex ) 
   return list_items.filter( list_item => regex.test( list_item.name ) )

}


function getSuggestionValue(suggestion) {
  return suggestion.name;
}

function renderSuggestion(suggestion) {
  return (
    <span>{suggestion.name}</span>
  );
}

class App extends Component {
  constructor() {
    super();
    this.state = {
      value: '',
      suggestions: []
    };    
  }

  onChange = (event, { newValue, method }) => {
    this.setState({
      value: newValue
    });
  };
  
  onSuggestionsFetchRequested = ({ value }) => {
    this.setState({
      suggestions: getSuggestions(value)
    });
  };

  onSuggestionsClearRequested = () => {
    this.setState({
      suggestions: []
    });
  };


 componentDidMount() {
   axios.get('http://doc-pub-host:3000/dev_ysg_issues/srch/confs/%' , {
      headers: { 
			"Access-Control-Allow-Origin": "*" }
   	})
      .then(response => {
			list_items = response.data 
         for(var i=0; i < response.data.length; i++) {
            
            var currentTime = new Date()
            // returns the year (four digits)

            var year = currentTime.getFullYear()
            year = (year < 10 ? '0' : '') + year

            // returns the month (from 0 to 11)
            var month = currentTime.getMonth() + 1
            month = (month < 10 ? '0' : '') + month

            // returns the day of the month (from 1 to 31)
            var day = currentTime.getDate()
            day = (day < 10 ? '0' : '') + day

            var name = response.data[i].name
            name = name.replace(/%YYYY%/g, year )
            name = name.replace(/%mm%/g, month )
            name = name.replace(/%dd%/g, day )
            list_items[i].name = name
         }

			// console.log ( "componentDidMount" ) 
			// console.log ( list_items ) 
         this.setState({ suggestions: list_items })
      });

  }

  render() {
    const { value, suggestions } = this.state;
    const inputProps = {
      placeholder: "search ...",
      value,
      onChange: this.onChange
    };

    return (
      <Autosuggest 
        suggestions={suggestions}
        onSuggestionsFetchRequested={this.onSuggestionsFetchRequested}
        onSuggestionsClearRequested={this.onSuggestionsClearRequested}
        getSuggestionValue={getSuggestionValue}
        renderSuggestion={renderSuggestion}
        inputProps={inputProps} />
    );
  }
}



export default App ; 

