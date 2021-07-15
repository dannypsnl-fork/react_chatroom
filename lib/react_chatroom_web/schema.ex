defmodule ReactChatroomWeb.Schema do
  use Absinthe.Schema

  import_types(ReactChatroomWeb.Schema.Account)
  import_types(ReactChatroomWeb.Schema.Room)
  import_types(ReactChatroomWeb.Schema.Message)

  query do
    @desc "Get a list of rooms"
    field :rooms, list_of(:room) do
      resolve(fn _, _params, _resolution ->
        {:ok, ReactChatroom.Chats.list_rooms()}
      end)
    end

    @desc "Get a list of messages of a room"
    field :messages, list_of(:message) do
      arg(:room_id, non_null(:id))

      resolve(fn _, %{room_id: room_id}, _resolution ->
        {:ok, ReactChatroom.Chats.list_messages(room_id)}
      end)
    end
  end

  mutation do
    field :login, :session do
      arg(:input, :login_input)

      resolve(fn _, %{input: %{name: name, password: pwd}}, _resolution ->
        case ReactChatroom.Accounts.authenticate(name, pwd) do
          {:ok, user} ->
            token =
              ReactChatroomWeb.Authenicate.sign(%{
                name: name,
                id: user.id
              })

            {:ok, %{token: token, user: user}}

          _ ->
            {:error, "login failed"}
        end
      end)
    end

    @desc "Create new room"
    field :create_room, :string do
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
      arg(:id, non_null(:id))

      resolve(fn _, %{id: id}, _resolution ->
        room = ReactChatroom.Chats.get_room!(id)

        case ReactChatroom.Chats.delete_room(room) do
          {:ok, _} -> {:ok, "room deleted"}
          {:error, err} -> {:error, inspect(err)}
        end
      end)
    end

    @desc "Create new message"
    field :create_message, :string do
      arg(:input, :create_message_input)

      resolve(fn _, %{input: params}, _resolution ->
        case ReactChatroom.Chats.create_message(params) do
          {:ok, _} -> {:ok, "message created"}
          {:error, err} -> {:error, inspect(err)}
        end
      end)
    end
  end
end
