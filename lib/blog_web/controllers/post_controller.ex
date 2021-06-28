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

  def new(conn, params) do
    render(conn, "new.html")
  end
end
