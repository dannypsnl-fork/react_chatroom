import React, { useState } from "react";
import { gql } from "@apollo/client";
import { useMutation } from "react-apollo";

const loginMutation = gql`
  mutation login($input: LoginInput!) {
    login(input: $input) {
      token
    }
  }
`;

export default function Login() {
  let [name, setUserName] = useState("");
  let [password, setPassword] = useState("");

  const [login] = useMutation(loginMutation, {
    onCompleted: ({ login: { token } }) => {
      localStorage.setItem("token", token);
    },
  });

  return (
    <>
      <h1>Login</h1>
      <label>
        name:
        <input
          value={name}
          onChange={(e) => setUserName(e.target.value)}
        ></input>
      </label>
      <label>
        password:
        <input
          value={password}
          onChange={(e) => setPassword(e.target.value)}
        ></input>
      </label>

      <button
        onClick={(_e) => login({ variables: { input: { name, password } } })}
      >
        Login
      </button>
    </>
  );
}
