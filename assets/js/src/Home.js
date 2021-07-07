import React, { useState } from "react";
import { Link, hashHistory } from "react-router-dom";
import { gql } from "apollo-boost";
import { Query, Mutation } from "react-apollo";

const getRoomsQuery = gql`
  {
    rooms {
      id
      name
    }
  }
`;

const createRoomQuery = gql`
  mutation ($name: String!) {
    createRoom(name: $name)
  }
`;

const deleteRoomQuery = gql`
  mutation ($id: ID!) {
    deleteRoom(id: $id)
  }
`;

function Room({ id, name }) {
  return (
    <li key={id}>
      <Link to={`room/${name}`}>{name}</Link>
      <Mutation
        mutation={deleteRoomQuery}
        refetchQueries={() => {
          return [{ query: getRoomsQuery }];
        }}
      >
        {(mutate, { _, loading, error }) => {
          if (loading) return "mutating";
          if (error) return `${error}`;

          return (
            <button
              onClick={(_e) => {
                mutate({ variables: { id } });
                hashHistory.push("/");
              }}
            >
              remove
            </button>
          );
        }}
      </Mutation>
    </li>
  );
}

export default function Home() {
  let [roomName, setRoomName] = useState("");

  return (
    <>
      <h1>Home</h1>
      <Mutation
        mutation={createRoomQuery}
        refetchQueries={() => {
          return [{ query: getRoomsQuery }];
        }}
      >
        {(mutate, { _, loading, error }) => {
          if (loading) return "mutating...";
          if (error) return `${error}`;
          let createNewRoom = () => {
            mutate({ variables: { name: roomName } });
            setRoomName("");
          };
          return (
            <>
              <input
                value={roomName}
                onChange={(e) => setRoomName(e.target.value)}
                onKeyDown={(e) => (e.key === "Enter" ? createNewRoom() : null)}
              ></input>
              <button onClick={(_e) => createNewRoom()}>
                create new rooms
              </button>
            </>
          );
        }}
      </Mutation>

      <Query query={getRoomsQuery}>
        {({ loading, error, data }) => {
          if (loading) return <p>Loading...</p>;
          if (error) return <p>Error :( {error}</p>;
          // 最重要的就是從 data 裡面取得資料
          const lists = data.rooms.map((room) => (
            <Room id={room.id} name={room.name}></Room>
          ));

          return (
            <div>
              <ul>{lists}</ul>
            </div>
          );
        }}
      </Query>
    </>
  );
}
