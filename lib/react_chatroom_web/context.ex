defmodule ReactChatroomWeb.Context do
  @behaviour Plug
  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _) do
    context = build_context(conn)
    Absinthe.Plug.put_options(conn, context: context)
  end

  defp build_context(conn) do
    with ["Bearer" <> token] <- get_req_header(conn, "authorization") do
      {:ok, data} = ReactChatroomWeb.Authenicate.verify(token)
      %{current_user: get_user(data)}
    else
      _ ->
        %{}
    end
  end

  defp get_user(%{id: id}) do
    ReactChatroom.Accounts.get_user(id)
  end
end
