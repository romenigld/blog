defmodule BlogWeb.PostController do
  use BlogWeb, :controller
  alias Blog.Posts.Post

  def index(conn, params) do
    posts = Blog.Repo.all(Post)
    render(conn, "index.html", posts: posts, valor: 2)
  end

  def show(conn, %{"id" => id}) do
    post = Blog.Repo.get!(Post, id)
    render(conn, "show.html", post: post)
  end

  def new(conn, _params) do
    changeset = Post.changeset(%Post{})
    render(conn, "new.html", changeset: changeset)
  end

  def edit(conn, %{"id" => id}) do
    post = Blog.Repo.get(Blog.Posts.Post, id)
    changeset = Post.changeset(%Post{}, post)
    render(conn, "edit.html", post: post, changeset: changeset)
  end

  def create(conn, %{"post" => post_params}) do
    post =
      Post.changeset(%Post{}, post_params)
      |>Blog.Repo.insert()

    case post do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post criado com sucesso!")
        |> redirect(to: Routes.post_path(conn, :show, post))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def update(conn, %{"id" => id, "post" => post_params}) do
    post = Blog.Repo.get(Blog.Posts.Post, id)
    post = Blog.Repo.update!(post, post_params)

    case post do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post atualizado com sucesso!")
        |> redirect(to: Routes.post_path(conn, :show, post))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    post = Blog.Repo.get!(Blog.Posts.Post, id)
    Blog.Repo.delete!(post)

    conn
    |> put_flash(:info, "Post foi deletado!")
    |> redirect(to: Routes.post_path(conn, :index))
  end

end
