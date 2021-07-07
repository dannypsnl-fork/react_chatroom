import React, { useState } from "react";
import { Link } from "react-router-dom";
import { gql } from "apollo-boost";
import { Query } from "react-apollo";

const getRoomsQuery = gql`
  {
    rooms {
      id
      name
    }
  }
`;

function Room({ index, name }) {
  return (
    <li key={index}>
      <Link to={`room/${name}`}>{name}</Link>
    </li>
  );
}

export default function Home() {
  let [roomName, setRoomName] = useState("");

  let createNewRoom = () => {
    setRoomName("");
  };

  return (
    <>
      <h1>Home</h1>
      <input
        value={roomName}
        onChange={(e) => setRoomName(e.target.value)}
        onKeyDown={(e) => (e.key === "Enter" ? createNewRoom() : null)}
      ></input>
      <button onClick={(_e) => createNewRoom()}>create new rooms</button>
      <Query query={getRoomsQuery}>
        {({ loading, error, data }) => {
          if (loading) return <p>Loading...</p>;
          if (error) return <p>Error :( {error}</p>;
          // 最重要的就是從 data 裡面取得資料
          const lists = data.rooms.map((room) => (
            <Room index={room.id} name={room.name}></Room>
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
