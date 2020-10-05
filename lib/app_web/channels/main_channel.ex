defmodule AppWeb.MainChannel do
  @moduledoc false

  use AppWeb, :channel

  alias App.Checksum
  alias App.PublicInteraction
  alias App.PublicInteraction.Message

  @impl Phoenix.Channel
  def join("inn:main", _payload, socket) do
    send(self(), :after_join)
    {:ok, socket}
  end

  defp format_datetime(%NaiveDateTime{} = dt) do
    pad = fn x -> String.pad_leading(to_string(x), 2, "0") end

    month = pad.(dt.month)
    day = pad.(dt.day)
    hour = pad.(dt.hour)
    minute = pad.(dt.minute)

    "#{dt.year}-#{month}-#{day} #{hour}:#{minute}"
  end

  defp format_msg(%Message{} = msg) do
    %{
      datetime: format_datetime(msg.inserted_at),
      inn: msg.value,
      is_correct: is_correct(msg)
    }
  end

  defp is_correct(%Message{} = msg) do
    case Checksum.check(msg.value) do
      {:ok, c} -> c
      _ -> false
    end
  end

  @impl Phoenix.Channel
  def handle_info(:after_join, socket) do
    PublicInteraction.recent_messages()
    |> Enum.each(fn msg -> push(socket, "new_message", format_msg(msg)) end)

    {:noreply, socket}
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  @impl Phoenix.Channel
  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (inn:main).
  @impl Phoenix.Channel
  def handle_in("shout", payload, socket) do
    broadcast(socket, "shout", payload)
    {:noreply, socket}
  end

  def handle_in("new_check", payload, socket) do
    {:ok, msg} = PublicInteraction.save_message(payload["inn"])
    broadcast!(socket, "new_message", format_msg(msg))
    {:noreply, socket}
  end
end
