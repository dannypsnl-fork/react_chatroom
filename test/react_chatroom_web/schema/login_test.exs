defmodule ReactChatroomWeb.Schema.LoginTest do
  use ReactChatroomWeb.ConnCase

  @login """
  mutation login($input: LoginInput) {
    login(input: $input) {
      user {
        name
      }
    }
  }
  """

  test "login success", %{conn: conn} do
    {:ok, _} = ReactChatroom.Accounts.create_user(%{name: "Test", password: "Test"})

    conn =
      post(conn, "/api/graph", %{
        "query" => @login,
        "variables" => %{input: %{name: "Test", password: "Test"}}
      })

    case json_response(conn, 200) do
      %{"errors" => result} ->
        flunk("failed #{inspect(result)}")

      %{"data" => %{"login" => result}} ->
        assert result == %{"user" => %{}}
    end
  end

  test "login failed", %{conn: conn} do
    {:ok, _} = ReactChatroom.Accounts.create_user(%{name: "Test", password: "Test"})

    conn =
      post(conn, "/api/graph", %{
        "query" => @login,
        "variables" => %{input: %{name: "Test", password: "ALWas"}}
      })

    case json_response(conn, 200) do
      %{"errors" => [%{"message" => result}]} ->
        assert result == "login failed"
    end
  end

  @rooms """
  query rooms {
    rooms {
      name
    }
  }
  """

  test "cannot list rooms without login", %{conn: conn} do
    conn = post(conn, "/api/graph", %{"query" => @rooms})

    case json_response(conn, 200) do
      %{"errors" => [%{"message" => result}]} ->
        assert result == "unauthenticated"
    end
  end
end
