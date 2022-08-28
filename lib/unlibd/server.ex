defmodule UnLibD.Server do
  @moduledoc false

  use GenServer
  alias UnLibD.State
  alias UnLibD.Auth

  @me __MODULE__

  def start_link(_opts) do
    empty_state = nil
    GenServer.start_link(__MODULE__, empty_state, name: @me)
  end

  @impl true
  def init(_opts) do
    state = State.new()
    schedule_next(state.interval)

    IO.puts("Running on #{node()}")

    {:ok, state}
  end

  @impl true
  def handle_info(:update, %State{} = state) do
    clean_read_lists()
    if state.enabled?, do: pull()

    schedule_next(state.interval)
    {:noreply, state}
  end

  @impl true
  def handle_call(:pull, _from, %State{} = state) do
    response = pull()
    {:reply, response, state}
  end

  @impl true
  def handle_call(:enabled?, _from, %State{} = state) do
    {:reply, state.enabled?, state}
  end

  @impl true
  def handle_cast(:enable, %State{} = state) do
    {:noreply, %State{state | enabled?: not state.enabled?}}
  end

  defp pull do
    response =
      Auth.current_user()
      |> UnLib.Feeds.pull()

    print_errors(response)
    response
  end

  defp clean_read_lists do
    UnLib.Sources.list()
    |> Enum.map(&Task.async(fn -> UnLib.Sources.clean_read_list(&1) end))
    |> Task.await_many(:infinity)
  end

  defp print_errors(response) do
    for data <- response do
      if data.error do
        IO.puts(
          IO.ANSI.red() <>
            IO.ANSI.bright() <>
            "Error: " <>
            IO.ANSI.reset() <>
            IO.ANSI.red() <>
            data.error <>
            IO.ANSI.reset()
        )
      end
    end
  end

  defp schedule_next(timeout) do
    Process.send_after(self(), :update, timeout)
  end
end
