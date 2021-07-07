import React, { useState } from "react";
import { Link } from "react-router-dom";

function Room({ index, name }) {
  return (
    <li key={index}>
      <Link to={`room/${name}`}>{name}</Link>
    </li>
  );
}

export default function Home() {
  let [roomName, setRoomName] = useState("");
  let [rooms, setRooms] = useState([{ name: "hi" }]);

  let createNewRoom = () => {
    setRooms([{ name: roomName }, ...rooms]);
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
      <ul>
        {rooms.map((room, index) => (
          <Room index={index} name={room.name}></Room>
        ))}
      </ul>
    </>
  );
}
