import React from "react";

export default function Room({ match }) {
  return (
    <>
      <h1>Room</h1>
      <p>{match.params.roomId}</p>
    </>
  );
}
