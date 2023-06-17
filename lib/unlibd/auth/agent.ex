defmodule UnLibD.Agent do
  @moduledoc false

  @me __MODULE__

  @spec start_link() :: {:ok, pid}
  def start_link() do
    Agent.start_link(&init_state/0, name: @me)
  end

  defp init_state(), do: {false, nil}

  @spec get(:logged_in) :: boolean()
  def get(:logged_in) do
    Agent.get(@me, fn {logged_in?, _user_id} -> logged_in? end)
  end

  @spec get(:user_id) :: Ecto.UUID.t() | nil
  def get(:user_id) do
    Agent.get(@me, fn {_logged_in?, user_id} -> user_id end)
  end

  @spec put(:logout) :: :ok
  def put(:logout) do
    Agent.update(@me, fn _state -> init_state() end)
  end

  @spec put(Ecto.UUID.t()) :: :ok
  def put(user_id) do
    Agent.update(@me, fn _state -> set_state(user_id) end)
  end

  defp set_state(user_id), do: {true, user_id}

  # Child spec

  def child_spec(_args) do
    %{
      id: @me,
      start: {@me, :start_link, []}
    }
  end
end
