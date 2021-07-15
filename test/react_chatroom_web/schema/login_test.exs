defmodule ReactChatroomWeb.Schema.LoginTest do
  use ReactChatroomWeb.ConnCase

  @login """
  mutation login($input: LoginInput) {
    login(input: $input) {
      token
    }
  }
  """

  test "login success", %{conn: conn} do
    ReactChatroom.Accounts.create_user(%{name: "Test", password: "Test"})

    conn =
      post(conn, "/api/graph", %{
        "query" => @login,
        "variables" => %{input: %{name: "Test", password: "Test"}}
      })

    case json_response(conn, 200) do
      %{"errors" => result} ->
        flunk("failed #{inspect(result)}")

      %{"data" => %{"login" => %{"token" => token}}} ->
        assert token != ""
    end
  end

  test "login failed", %{conn: conn} do
    ReactChatroom.Accounts.create_user(%{name: "Test", password: "Test"})

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

  test "login user can list rooms", %{conn: conn} do
    ReactChatroom.Accounts.create_user(%{name: "Test", password: "Test"})

    conn =
      post(conn, "/api/graph", %{
        "query" => @login,
        "variables" => %{input: %{name: "Test", password: "Test"}}
      })

    case json_response(conn, 200) do
      %{"errors" => result} ->
        flunk("failed #{inspect(result)}")

      %{
        "data" => %{
          "login" => %{
            "token" => token
          }
        }
      } ->
        conn =
          build_conn()
          |> put_req_header(
            "authorization",
            "Bearer" <> token
          )
          |> post("/api/graph", %{"query" => @rooms})

        case json_response(conn, 200) do
          %{"errors" => [%{"message" => result}]} ->
            flunk("failed #{inspect(result)}")

          %{"data" => %{"rooms" => result}} ->
            assert result == []
        end
    end
  end
end
