defmodule ReactChatroom.Chats.Message do
  use Ecto.Schema
  import Ecto.Changeset

  schema "messages" do
    belongs_to(:room, ReactChatroom.Chats.Room)

    field :name, :string
    field :body, :string

    timestamps()
  end

  @doc false
  def changeset(message, attrs) do
    message
    |> cast(attrs, [:room_id, :name, :body])
    |> validate_required([:room_id, :name, :body])
  end
end
