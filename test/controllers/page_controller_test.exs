defmodule Aggit.PageControllerTest do
  use Aggit.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Welcome to Aggit!"
  end
end
