import React from 'react';
import './App.css';
import welcome from './components/welcome';
import Visits from './components/Visits';
import visitsResults from './components/visitsResults';
import covid from './components/covid-19';
import exposed_areas from './components/find_exposed_areas';
//import SessionPerProviderTable from './components/SessionPerProviderTable';
import {BrowserRouter as Router, Route, Switch} from 'react-router-dom';
//import {AuthContext} from "./context/authentication";
//import SessionsPerEV from "./components/SessionsPerEV";

function App() {

  const [authToken, setAuthToken] = React.useState();

  const setToken = (data) => {
    localStorage.setItem("access-token", JSON.stringify(data));
    setAuthToken(data);
  }

  return (
        <Router>
          <Switch>
            <Route path='/' exact={true} component={welcome}/>
            <Route path='/covid/' exact={true} component={covid}/>
            <Route path='/visits/' exact={true} component={Visits}/>
              <Route path='/find_exposed_areas/:id' exact={true} component={exposed_areas}/>
            <Route path='/visitsResults/:service/:cost/:dateFrom/:dateTo' exact={true} component={visitsResults}/>
          </Switch>
        </Router>
  );
}

export default App;
