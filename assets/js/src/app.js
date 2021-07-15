import React, { useState } from "react";
import { BrowserRouter as Router, Switch, Route, Link } from "react-router-dom";
import { define } from "remount";
import Home from "./Home";
import About from "./About";
import Room from "./Room";
import Login from "./Login";
import { ApolloProvider } from "react-apollo";
import { ApolloClient, createHttpLink, InMemoryCache } from "@apollo/client";
import { setContext } from "@apollo/client/link/context";

const httpLink = createHttpLink({
  uri: "/api/graph",
  credentials: "same-origin",
});

const authLink = setContext((_, { headers }) => {
  // get the authentication token from local storage if it exists
  const token = localStorage.getItem("token");

  // return the headers to the context so httpLink can read them
  return {
    headers: {
      ...headers,
      authorization: token ? `Bearer${token}` : "",
    },
  };
});

const client = new ApolloClient({
  link: authLink.concat(httpLink),
  cache: new InMemoryCache(),
});

const App = () => {
  const [hasToken, setHasToken] = useState(false);
  if (!hasToken && !localStorage.getItem("token")) {
    return (
      <ApolloProvider client={client}>
        <Login setHasToken={setHasToken} />
      </ApolloProvider>
    );
  }

  return (
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
};

define({ "x-app": App });
