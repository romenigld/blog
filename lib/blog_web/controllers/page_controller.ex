defmodule BlogWeb.PageController do
  use BlogWeb, :controller

  def index(conn, _params) do
    IO.inspect(self())
    render(conn, "index.html")
  end
end
