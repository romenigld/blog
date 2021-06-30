defmodule BlogWeb.CommentsChannel do
  use BlogWeb, :channel

  def join(name, _payload, socket), do: {:ok, %{nome: "Comments Channel deu certo!"}, socket}

  def handle_in() do

  end
end
