defmodule ReactChatroomWeb.Schema.Room do
  use Absinthe.Schema.Notation
  alias ReactChatroomWeb.Schema.Middleware.Auth

  object :room do
    field :id, :string do
      resolve(fn %ReactChatroom.Chats.Room{} = room, _, _ ->
        {:ok, ReactChatroomWeb.Authenicate.encode(room.id)}
      end)
    end

    field :name, :string
  end

  object :room_queries do
    @desc "Get a list of rooms"
    field :rooms, list_of(:room) do
      middleware(Auth)

      resolve(fn _, _params, _resolution ->
        {:ok, ReactChatroom.Chats.list_rooms()}
      end)
    end
  end

  object :room_mutations do
    @desc "Create new room"
    field :create_room, :string do
      middleware(Auth)
      arg(:name, non_null(:string))

      resolve(fn _, params, _resolution ->
        case ReactChatroom.Chats.create_room(params) do
          {:ok, _} -> {:ok, "room created"}
          {:error, err} -> {:error, inspect(err)}
        end
      end)
    end

    @desc "Delete room"
    field :delete_room, :string do
      middleware(Auth)
      arg(:id, non_null(:string))

      resolve(fn _, %{id: id_str}, _resolution ->
        room = ReactChatroom.Chats.get_room!(ReactChatroomWeb.Authenicate.decode(id_str))

        case ReactChatroom.Chats.delete_room(room) do
          {:ok, _} -> {:ok, "room deleted"}
          {:error, err} -> {:error, inspect(err)}
        end
      end)
    end
  end
end
