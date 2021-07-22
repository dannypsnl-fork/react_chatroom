defmodule ReactChatroomWeb.Schema.Message do
  use Absinthe.Schema.Notation
  alias ReactChatroomWeb.Schema.Middleware.Auth

  input_object :create_message_input do
    field :room_id, non_null(:string)
    field :body, non_null(:string)
  end

  object :message do
    field :id, :string do
      resolve(fn %ReactChatroom.Chats.Message{} = msg, _, _ ->
        {:ok, ReactChatroomWeb.Authenicate.encode(msg.id)}
      end)
    end

    field :name, :string do
      resolve(fn %ReactChatroom.Chats.Message{} = msg, _, _ ->
        user = ReactChatroom.Accounts.get_user(msg.user_id)
        {:ok, user.name}
      end)
    end

    field :body, :string
  end

  object :message_queries do
    @desc "Get a list of messages of a room"
    field :messages, list_of(:message) do
      middleware(Auth)
      arg(:room_id, non_null(:string))

      resolve(fn _, %{room_id: room_id_str}, _resolution ->
        room_id = ReactChatroomWeb.Authenicate.decode(room_id_str)
        {:ok, ReactChatroom.Chats.list_messages(room_id)}
      end)
    end
  end

  object :message_mutations do
    @desc "Create new message"
    field :create_message, :string do
      middleware(Auth)
      arg(:input, :create_message_input)

      resolve(fn _,
                 %{input: %{body: body, room_id: room_id_str}},
                 %{context: %{current_user: user}} ->
        room_id = ReactChatroomWeb.Authenicate.decode(room_id_str)

        case ReactChatroom.Chats.create_message(%{room_id: room_id, user_id: user.id, body: body}) do
          {:ok, _} -> {:ok, "message created"}
          {:error, err} -> {:error, inspect(err)}
        end
      end)
    end
  end
end
