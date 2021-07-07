defmodule ReactChatroom.Chats.Message do
  use Ecto.Schema
  import Ecto.Changeset

  schema "messages" do
    belongs_to(:user, ReactChatroom.Chats.User)

    field :body, :string

    timestamps()
  end

  @doc false
  def changeset(message, attrs) do
    message
    |> cast(attrs, [:body])
    |> validate_required([:body])
  end
end
