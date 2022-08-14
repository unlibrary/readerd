defmodule UnLibD.State do
  @moduledoc false

  defstruct [:interval, :enabled?]

  @type t() :: %__MODULE__{
          interval: integer(),
          enabled?: boolean()
        }

  @spec new :: t()
  def new do
    %__MODULE__{
      interval: Application.fetch_env!(:unlibd, :interval),
      enabled?: Application.fetch_env!(:unlibd, :autopull)
    }
  end
end
