defmodule BlogWebChannelTest do
  use BlogWeb.ChannelCase
  alias BlogWeb.UserSocket

  @valid_post %{
    title: "Phoenix Framework",
    description: "Lorem"
  }

  test "deve se conectar ao socket" do
    {:ok, post} = Blog.Posts.create_post(@valid_post)

    {:ok, socket} = connect(UserSocket, %{})
    {:ok, comentarios, socket} = subscribe_and_join(socket, "comments:#{post.id}", %{})
    assert post.id == socket.assigns.post_id
    assert [] == comentarios.comments
  end
end
