defmodule ReactChatroomWeb.Schema.Room do
  use Absinthe.Schema.Notation

  object :room do
    field :id, :id
    field :name, :string
  end
end
