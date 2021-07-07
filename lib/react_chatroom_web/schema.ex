defmodule ReactChatroomWeb.Schema do
  use Absinthe.Schema

  import_types(ReactChatroomWeb.Schema.Room)

  query do
    @desc "Get a list of rooms"
    field :rooms, list_of(:room) do
      resolve(fn _, _params, _resolution ->
        {:ok, ReactChatroom.Chats.list_rooms()}
      end)
    end
  end

  mutation do
    @desc "Create new room"
    field :create_room, :string do
      arg(:name, :string)

      resolve(fn _, params, _resolution ->
        case ReactChatroom.Chats.create_room(params) do
          {:ok, _} -> {:ok, "room created"}
          {:error, err} -> {:error, inspect(err)}
        end
      end)
    end

    @desc "Delete room"
    field :delete_room, :string do
      arg(:id, :id)

      resolve(fn _, %{id: id}, _resolution ->
        room = ReactChatroom.Chats.get_room!(id)

        case ReactChatroom.Chats.delete_room(room) do
          {:ok, _} -> {:ok, "room deleted"}
          {:error, err} -> {:error, inspect(err)}
        end
      end)
    end
  end
end
