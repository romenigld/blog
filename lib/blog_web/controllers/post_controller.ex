defmodule BlogWeb.PostController do
  use BlogWeb, :controller

  def index(conn, params) do
    posts = [
      %{
        id: 1,
        title: "Phoenix"
      },
      %{
        id: 2,
        title: "LiveView"
      },
      %{
        id: 3,
        title: "PostgreSQL"
      }
    ]

    render(conn, "index.html", posts: posts, valor: 2)
  end

  def show(conn, params) do
    render(conn, "show.html")
  end
end
