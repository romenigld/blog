defmodule BlogWeb.PostControllerTest do
  use BlogWeb.ConnCase

  @valid_post %{
    title: "Phoenix Framework",
    description: "Lorem"
  }

  @update_post %{
    title: "Update 123",
    description: "Updated"
  }

  defp fixture(:post) do
    user = Blog.Accounts.get_user!(1)
    {:ok, post} = Blog.Posts.create_post(user, @valid_post)
    post
  end

  test "entrar no formulário de criação de posts", %{conn: conn} do
    conn = get(conn, Routes.post_path(conn, :new))
    assert html_response(conn, 200) =~ "Criar Post"
  end

  test "criar um post", %{conn: conn} do
    conn =
      conn
      |> Plug.Test.init_test_session(user_id: 1)
      |> post(Routes.post_path(conn, :create), post: @valid_post)

    assert %{id: id} = redirected_params(conn)
    assert redirected_to(conn) == Routes.post_path(conn, :show, id)

    conn = get(conn, Routes.post_path(conn, :show, id))
    assert html_response(conn, 200) =~ "Phoenix Framework"
  end

  test "criar um posts com valores inválidos", %{conn: conn} do
    conn = post(conn, Routes.post_path(conn, :create), post: %{})
    assert html_response(conn, 200) =~ "campo obrigatório"
  end

  describe "depende de post criado os testes abaixo" do
    setup [:criar_post]

    test "listar todos os posts", %{conn: conn} do
      user = Blog.Accounts.get_user!(1)
      Blog.Posts.create_post(user, @valid_post)
      conn = get(conn, Routes.post_path(conn, :index))
      assert html_response(conn, 200) =~ "Phoenix Framework"
    end

    test "pegar um post por id", %{conn: conn, post: post} do
      user = Blog.Accounts.get_user!(1)
      {:ok, post } = Blog.Posts.create_post(user, @valid_post)
      conn = get(conn, Routes.post_path(conn, :show, post))
      assert html_response(conn, 200) =~ "Phoenix Framework"
    end

    test "entrar no formulário de alteração de posts", %{conn: conn, post: post} do
      user = Blog.Accounts.get_user!(1)
      {:ok, post } = Blog.Posts.create_post(user, @valid_post)
      conn = get(conn, Routes.post_path(conn, :edit, post))
      assert html_response(conn, 200) =~ "Editar Post"
    end

    test "alterar um post", %{conn: conn, post: post} do
      conn = put(conn, Routes.post_path(conn, :update, post), post: @update_post)
      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.post_path(conn, :show, id)
      conn = get(conn, Routes.post_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Update 123"
    end

    test "alterar um posts com valores inválidos", %{conn: conn, post: post} do
      conn =
        put(conn, Routes.post_path(conn, :update, post), post: %{title: nil, description: nil})

      assert html_response(conn, 200) =~ "campo obrigatório"
    end

    test "delete post", %{conn: conn, post: post} do
      conn = delete(conn, Routes.post_path(conn, :delete, post))
      assert redirected_to(conn) == Routes.post_path(conn, :index)
      assert_error_sent 404, fn -> get(conn, Routes.post_path(conn, :show, post)) end
    end
  end

  defp criar_post(_) do
    %{post: fixture(:post)}
  end
end
