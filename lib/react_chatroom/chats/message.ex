defmodule ReactChatroom.Chats.Message do
  use Ecto.Schema
  import Ecto.Changeset

  schema "messages" do
    belongs_to(:room, ReactChatroom.Chats.Room)
    belongs_to(:user, ReactChatroom.Accounts.User)

    field :body, :string

    timestamps()
  end

  @doc false
  def changeset(message, attrs) do
    message
    |> cast(attrs, [:room_id, :user_id, :body])
    |> validate_required([:room_id, :user_id, :body])
  end
end
