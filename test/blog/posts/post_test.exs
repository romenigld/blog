defmodule Blog.PostsTest do
  use Blog.DataCase
  alias Blog.{Posts, Posts.Post}

  @valid_post %{
    title: "Phoenix Framework",
    description: "Lorem"
  }
  @update_post %{
    title: "Update",
    description: "Updated"
  }

  def post_fixture(_attrs \\ %{}) do
    {:ok, post} = Posts.create_post(@valid_post)
    post
  end

  test "list_post/0 return all posts" do
    post = post_fixture()
    assert Posts.list_posts() == [post]
  end

  test "get_post/1 return all posts" do
    post = post_fixture()
    assert Posts.get_post!(post.id) == post
  end

  test "create_post/1 with valid data" do
    assert {:ok, %Post{} = post} = Posts.create_post(@valid_post)
    assert post.title == "Phoenix Framework"
    assert post.description == "Lorem"
  end

  test "update_post/2 with valid data" do
    post = post_fixture()

    assert {:ok, %Post{} = post} = Posts.update_post(post, @update_post)
    assert post.title == "Update"
    assert post.description == "Updated"
  end

  test "delete/1" do
    post = post_fixture()
    assert post = Posts.delete(post.id)
    assert_raise Ecto.NoResultsError, fn -> Posts.get_post!(post.id) end
  end
end
