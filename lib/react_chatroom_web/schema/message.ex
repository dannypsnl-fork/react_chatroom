defmodule ReactChatroomWeb.Schema.Message do
  use Absinthe.Schema.Notation

  input_object :create_message_input do
    field :room_id, non_null(:id)
    field :name, non_null(:string)
    field :body, non_null(:string)
  end

  object :message do
    field :id, :id
    field :name, :string
    field :body, :string
  end
end
