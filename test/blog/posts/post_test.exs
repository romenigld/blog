defmodule Blog.PostsTest do
  use Blog.DataCase
  alias Blog.{Posts, Posts.Post}

  @valid_post %{
    title: "Phoenix Framework",
    description: "Lorem"
  }

  test "create_post/1 with valid data" do
    assert {:ok, %Post{} = post} = Posts.create_post(@valid_post)
    assert post.title == "Phoenix Framework"
    assert post.description == "Lorem"
  end
end
