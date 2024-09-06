defmodule FlightTracker.CleanupInjector do
  # alias FlightTracker.MessageBroadcaster
  use GenServer
  require Logger

  def start_link(_) do
    GenServer.start_link(__MODULE__, name: __MODULE__)
  end

  @impl true
  def init(:ok) do
    Process.send_after(self(), :cleanup, 1_000 * 60 * 10)

    {:ok, :cleanup_started}
  end

  @impl true
  def handle_info(:cleanup, state) do
    Process.send_after(self(), :cleanup, 1_000 * 60 * 10)
    {:noreply, state}
  end
end
