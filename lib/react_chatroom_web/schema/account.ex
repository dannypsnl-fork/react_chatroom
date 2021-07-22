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

  object :account_mutations do
    field :login, :session do
      arg(:input, :login_input)

      resolve(fn _, %{input: %{name: name, password: pwd}}, _resolution ->
        case ReactChatroom.Accounts.authenticate(name, pwd) do
          {:ok, user} ->
            token =
              ReactChatroomWeb.Authenicate.sign(%{
                id: user.id
              })

            {:ok, %{token: token, user: user}}

          _ ->
            {:error, "login failed"}
        end
      end)
    end
  end
end
