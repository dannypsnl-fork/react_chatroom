import React from "react";
import { BrowserRouter as Router, Switch, Route, Link } from "react-router-dom";
import { define } from "remount";
import Home from "./Home";
import About from "./About";

const App = () => (
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
        <Route path="/">
          <Home />
        </Route>
      </Switch>
    </ul>
  </Router>
);

define({ "x-app": App });
