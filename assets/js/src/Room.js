import React, { useState } from "react";
import { gql } from "@apollo/client";
import { useQuery, useMutation } from "react-apollo";

const getMessagesQuery = gql`
  query ListMessage($roomId: ID!) {
    messages(roomId: $roomId) {
      id
      name
      body
    }
  }
`;

const createMessagesQuery = gql`
  mutation CreateMessage($input: CreateMessageInput) {
    createMessage(input: $input)
  }
`;

export default function Room({
  match: {
    params: { roomId },
  },
}) {
  const { loading, error, data } = useQuery(getMessagesQuery, {
    variables: { roomId },
  });
  const [msg, setMsg] = useState("");
  const [createMessage] = useMutation(createMessagesQuery, {
    refetchQueries: [{ query: getMessagesQuery, variables: { roomId } }],
  });

  const addMessage = () => {
    createMessage({
      variables: {
        input: {
          roomId,
          body: msg,
        },
      },
    });
    setMsg("");
  };

  if (loading) return <p>Loading...</p>;
  if (error) return <p>Error :( {error}</p>;
  return (
    <>
      <h1>Room</h1>
      <input
        value={msg}
        onChange={(e) => setMsg(e.target.value)}
        onKeyDown={(e) => (e.key === "Enter" ? addMessage() : null)}
      ></input>
      <button onClick={(_e) => addMessage()}>create new message</button>
      <ul>
        {data.messages.map((message) => (
          <li key={message.id}>
            {message.name}: {message.body}
          </li>
        ))}
      </ul>
    </>
  );
}
