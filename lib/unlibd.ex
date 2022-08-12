defmodule UnLibD do
  @moduledoc """
  Public API for `UnLibD.Server`.

  GenServer that pulls new entries every X minutes.
  This feature is optional and can be disabled in the application
  config located in `config/runtime.exs`.
  """
  alias UnLibD.Server

  def enable do
    GenServer.cast(Server, :enable)
  end

  def enabled? do
    GenServer.call(Server, :enabled?)
  end

  def pull_now do
    send(Server, :pull)
  end

  # Child spec

  def child_spec(opts) do
    %{
      id: Keyword.get(opts, :id, __MODULE__),
      start: {Server, :start_link, [opts]}
    }
  end
end
