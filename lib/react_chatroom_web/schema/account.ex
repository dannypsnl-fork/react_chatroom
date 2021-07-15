defmodule ReactChatroomWeb.Schema.Account do
  use Absinthe.Schema.Notation

  input_object :login_input do
    field :name, non_null(:string)
    field :password, non_null(:string)
  end

  object :session do
    field :token, :string
    field :user, :user
  end

  interface :user do
    field :name, :string
  end
end
