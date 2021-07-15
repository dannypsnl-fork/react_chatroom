defmodule ReactChatroom.Accounts do
  import Ecto.Query, warn: false
  alias ReactChatroom.Repo
  alias Comeonin.Ecto.Password
  alias ReactChatroom.Accounts.User

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  def get_user(id) do
    Repo.get_by(User, id: id)
  end

  @spec authenticate(String.t(), String.t()) :: :error | {:ok, User}
  def authenticate(name, password) do
    user = Repo.get_by!(User, name: name)

    with %{password: digest} <- user,
         true <- Password.valid?(password, digest) do
      {:ok, user}
    else
      _ -> :error
    end
  end
end
