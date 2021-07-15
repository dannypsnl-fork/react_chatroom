defmodule ReactChatroomWeb.Schema.Message do
  use Absinthe.Schema.Notation

  input_object :create_message_input do
    field :room_id, non_null(:id)
    field :body, non_null(:string)
  end

  object :message do
    field :id, :id

    field :name, :string do
      resolve(fn %ReactChatroom.Chats.Message{} = msg, _, _ ->
        user = ReactChatroom.Accounts.get_user(msg.user_id)
        {:ok, user.name}
      end)
    end

    field :body, :string
  end
end
