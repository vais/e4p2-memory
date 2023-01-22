defmodule MemoryWeb.Live.MemoryDisplay do
  use MemoryWeb, :live_view

  def mount(_params, _session, socket) do
    if connected?(socket) do
      tick()
    end

    {:ok, tock(socket)}
  end

  def handle_info(:tick, socket) do
    tick()
    {:noreply, tock(socket)}
  end

  defp tock(socket) do
    assign(socket, :memory, :erlang.memory())
  end

  defp tick do
    Process.send_after(self(), :tick, 1000)
  end

  def render(assigns) do
    ~L"""
    <table>
      <%= for {name, value} <- @memory do %>
      <tr>
        <th><%= name %></th>
        <td><%= value %></td>
      </tr>
      <% end %>
    </table>
    """
  end
end
