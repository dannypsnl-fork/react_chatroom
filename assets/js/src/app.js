import React from "react";
import { BrowserRouter as Router, Switch, Route, Link } from "react-router-dom";
import { define } from "remount";
import Home from "./Home";
import About from "./About";
import Room from "./Room";
import { ApolloProvider } from "react-apollo";
import ApolloClient from "apollo-boost";

const client = new ApolloClient({
  uri: "/api/graph",
});

const App = () => (
  <ApolloProvider client={client}>
    <Router>
      <h1> React App </h1>
      <ul>
        <li>
          <Link to="/">Home</Link>
        </li>
        <li>
          <Link to="/about">About</Link>
        </li>

        <Switch>
          <Route path="/about">
            <About />
          </Route>
          <Route path="/room/:roomId" component={Room}></Route>
          <Route path="/">
            <Home />
          </Route>
        </Switch>
      </ul>
    </Router>
  </ApolloProvider>
);

define({ "x-app": App });
