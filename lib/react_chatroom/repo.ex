defmodule ReactChatroom.Repo do
  use Ecto.Repo,
    otp_app: :react_chatroom,
    adapter: Ecto.Adapters.Postgres
end
