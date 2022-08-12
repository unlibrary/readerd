defmodule UnLibD.State do
  @moduledoc false

  defstruct interval: :timer.minutes(2), enabled?: false

  @type t() :: %__MODULE__{
          interval: integer(),
          enabled?: boolean()
        }

  def new do
    %__MODULE__{}
  end
end
