defmodule UnLibD.Server do
  @moduledoc false

  use GenServer
  alias UnLibD.State

  @me __MODULE__

  def start_link(_opts) do
    GenServer.start_link(__MODULE__, nil, name: @me)
  end

  @impl true
  def init(_opts) do
    state = State.new()
    schedule_next(state.interval)

    {:ok, state}
  end

  @impl true
  def handle_info(:update, %State{} = state) do
    if state.enabled? do
      send(self(), :pull)
    end

    schedule_next(state.interval)
    {:noreply, state}
  end

  @impl true
  def handle_info(:pull, %State{} = state) do
    UnLib.Feeds.pull_all()

    {:noreply, state}
  end

  @impl true
  def handle_call(:enabled?, _from, %State{} = state) do
    {:reply, state.enabled?, state}
  end

  @impl true
  def handle_cast(:enable, %State{} = state) do
    {:noreply, %State{state | enabled?: not state.enabled?}}
  end

  defp schedule_next(timeout) do
    Process.send_after(self(), :update, timeout)
  end
end
