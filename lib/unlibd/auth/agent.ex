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
    Agent.get(@me, fn {logged_in, _} -> logged_in end)
  end

  @spec get(:user) :: UnLib.Account.t()
  def get(:user) do
    Agent.get(@me, fn {_, user} -> user end)
  end

  @spec put(:logout) :: :ok
  def put(:logout) do
    Agent.update(@me, fn _state -> init_state() end)
  end

  @spec put(UnLib.Account.t()) :: :ok
  def put(account) do
    Agent.update(@me, fn _state -> set_state(account) end)
  end

  defp set_state(account), do: {true, account}

  # Child spec

  def child_spec(_args) do
    %{
      id: @me,
      start: {@me, :start_link, []}
    }
  end
end
