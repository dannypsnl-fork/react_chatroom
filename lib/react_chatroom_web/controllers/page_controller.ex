defmodule ReactChatroomWeb.PageController do
  use ReactChatroomWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
