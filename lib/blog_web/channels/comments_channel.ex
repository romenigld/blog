defmodule BlogWeb.CommentsChannel do
  use BlogWeb, :channel

  def join("comments:"<> post_id, payload, socket) do
    IO.inspect post_id, label: "post_id"
    IO.inspect payload, label: "Payload"
    IO.inspect socket, label: "Socket"

    {:ok, %{nome: "Comments Channel deu certo!"}, socket}
  end

  def handle_in() do

  end
end
