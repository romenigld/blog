defmodule BlogWeb.PostController do
  use BlogWeb, :controller

  def index(conn, params) do
    posts = [
      %{
        title: "Phoenix"
      },
      %{
        title: "LiveView"
      },
      %{
        title: "PostgreSQL"
      }
    ]

    render(conn, "index.html", posts: posts, valor: 2)
  end
end
