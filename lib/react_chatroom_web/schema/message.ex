defmodule ReactChatroomWeb.Schema.Message do
  use Absinthe.Schema.Notation

  object :message do
    field :id, :id
    field :name, :string
    field :body, :string
  end
end
