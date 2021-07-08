defmodule BlogWeb.PostController do
  use BlogWeb, :controller
  alias Blog.{Posts, Posts.Post}

  plug :check_owner when action in [:edit, :update, :delete]
  plug BlogWeb.Plug.RequireAuth when action in [:create, :new, :edit, :update, :delete]

  def check_owner(conn, _) do
    %{params: %{"id" => post_id}} = conn

    if Posts.get_post!(post_id).user_id == conn.assigns.user.id do
      conn
    else
      conn
      |> put_flash(:error, "Você não tem permissão para esta operação!")
      |> redirect(to: Routes.page_path(conn, :index))
      |> halt()
    end
  end

  def index(conn, _params) do
    posts = Posts.list_posts(conn.assigns[:user].id)
    render(conn, "index.html", posts: posts, valor: 2)
  end

  def show(conn, %{"id" => id}) do
    post = Posts.get_post!(id)
    render(conn, "show.html", post: post)
  end

  def new(conn, _params) do
    changeset = Post.changeset(%Post{})
    render(conn, "new.html", changeset: changeset)
  end

  def edit(conn, %{"id" => id}) do
    post = Posts.get_post!(id)
    changeset = Post.changeset(post)
    render(conn, "edit.html", post: post, changeset: changeset)
  end

  def create(conn, %{"post" => post_params}) do
    case Posts.create_post(conn.assigns[:user], post_params) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post criado com sucesso!")
        |> redirect(to: Routes.post_path(conn, :show, post))

      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def update(conn, %{"id" => id, "post" => post_params}) do
    post = Posts.get_post!(id)

    case Posts.update_post(post, post_params) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post atualizado com sucesso!")
        |> redirect(to: Routes.post_path(conn, :show, post))

      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset, post: post)
    end
  end

  def delete(conn, %{"id" => id}) do
    Posts.delete(id)

    conn
    |> put_flash(:info, "Post foi deletado!")
    |> redirect(to: Routes.post_path(conn, :index))
  end
end
