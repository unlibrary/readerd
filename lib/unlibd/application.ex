defmodule UnLibD.Application do
  @moduledoc false

  use Application

  @opts [strategy: :one_for_one, name: UnLibD.Supervisor]

  @impl true
  def start(_type, _args) do
    children = [
      UnLibD.Agent,
      UnLibD
    ]

    Supervisor.start_link(children, @opts)
  end
end
