import React from "react";
import { gql } from "apollo-boost";
import { useQuery } from "react-apollo";

const getMessagesQuery = gql`
  query ListMessage($roomId: ID!) {
    messages(roomId: $roomId) {
      id
      name
      body
    }
  }
`;

export default function Room({ match }) {
  const { loading, error, data } = useQuery(getMessagesQuery, {
    variables: {
      roomId: match.params.roomId,
    },
  });

  if (loading) return <p>Loading...</p>;
  if (error) return <p>Error :( {error}</p>;

  return (
    <>
      <h1>Room</h1>
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
