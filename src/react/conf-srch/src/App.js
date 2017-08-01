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
   axios.get('http://doc-pub-host:3000/prd_ysg_issues/srch/confs/%' , {
      headers: { 
			"Access-Control-Allow-Origin": "*" }
   	})
      .then(response => {
			list_items = response.data 
			// console.log ( "componentDidMount" ) 
			// console.log ( list_items ) 
         this.setState({ suggestions: list_items })
      });

  }

  render() {
    const { value, suggestions } = this.state;
    const inputProps = {
      placeholder: "Type 'c'",
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

