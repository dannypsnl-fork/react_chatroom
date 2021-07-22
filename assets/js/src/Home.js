import React, { useState } from "react";
import { Link } from "react-router-dom";
import { gql } from "@apollo/client";
import { useQuery, useMutation } from "react-apollo";

const getRoomsQuery = gql`
  query {
    rooms {
      id
      name
    }
  }
`;

const createRoomMutation = gql`
  mutation ($name: String!) {
    createRoom(name: $name)
  }
`;

const deleteRoomMutation = gql`
  mutation ($id: String!) {
    deleteRoom(id: $id)
  }
`;

export default function Home() {
  let [roomName, setRoomName] = useState("");
  const { loading, error, data } = useQuery(getRoomsQuery);
  const [mutate] = useMutation(createRoomMutation, {
    refetchQueries: [{ query: getRoomsQuery }],
  });
  let createNewRoom = () => {
    mutate({ variables: { name: roomName } });
    setRoomName("");
  };

  if (loading) return <p>Loading...</p>;
  if (error) {
    console.error({ error });
    return <p>Error :(</p>;
  }
  return (
    <>
      <h1>Home</h1>
      <input
        value={roomName}
        onChange={(e) => setRoomName(e.target.value)}
        onKeyDown={(e) => (e.key === "Enter" ? createNewRoom() : null)}
      ></input>
      <button onClick={(_e) => createNewRoom()}>create new rooms</button>
      <ul>
        {data.rooms.map((room) => (
          <RoomLink id={room.id} name={room.name}></RoomLink>
        ))}
      </ul>
    </>
  );
}

function RoomLink({ id, name }) {
  const [mutate, { _, loading, error }] = useMutation(deleteRoomMutation, {
    refetchQueries: [{ query: getRoomsQuery }],
  });

  if (loading) return "mutating";
  if (error) return `${error}`;
  return (
    <li key={id}>
      <Link to={`room/${id}`}>{name}</Link>
      <button
        onClick={(_e) => {
          mutate({ variables: { id } });
        }}
      >
        remove
      </button>
    </li>
  );
}
