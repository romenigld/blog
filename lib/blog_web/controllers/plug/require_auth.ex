defmodule BlogWeb.Plug.RequireAuth do
  use BlogWeb, :controller

  def init(_), do: nil

  def call(conn, _) do
    if conn.assigns[:user] do
      conn
    else
      conn
      |> put_flash(:error, "Você precisa estar logado!!!")
      |> redirect(to: Routes.page_path(conn, :index))
      |> halt
    end
  end
end
