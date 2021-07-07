import React from "react";
import { BrowserRouter as Router, Switch, Route, Link } from "react-router-dom";
import { define } from "remount";
import Home from "./Home";
import About from "./About";
import Room from "./Room";

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
        <Route path="/room/:roomId" component={Room}></Route>
        <Route path="/">
          <Home />
        </Route>
      </Switch>
    </ul>
  </Router>
);

define({ "x-app": App });
