defmodule UnLibD.Server do
  @moduledoc false

  use GenServer
  alias UnLibD.State
  alias UnLibD.Auth
  alias UnLibD.Logger

  def start_link(opts) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
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

  @spec pull() :: [UnLib.Feeds.Data.t()]
  defp pull do
    Logger.info("Info: Pulling feeds")

    response =
      case Auth.current_user() do
        %UnLib.Account{} = account -> UnLib.Feeds.pull(account)
        _ -> []
      end

    print_errors(response)
    response
  end

  defp print_errors(response) do
    for data <- response do
      if data.error do
        Logger.error(data.error)
      end
    end
  end

  defp schedule_next(timeout) do
    Process.send_after(self(), :update, timeout)
  end
end
