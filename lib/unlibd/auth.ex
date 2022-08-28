defmodule UnLibD.Auth do
  @moduledoc """
  Handles user authentication.
  """

  alias UnLibD.Agent

  @spec login(String.t(), String.t()) :: :ok
  def login(username, password) do
    case UnLib.Accounts.login(username, password) do
      {:ok, account} -> Agent.put(account.id)
      {:error, error} -> error
    end
  end

  @spec logout :: :ok
  def logout do
    Agent.put(:logout)
  end

  @spec current_user :: UnLib.Account.t()
  def current_user do
    if id = Agent.get(:user) do
      {:ok, account} =UnLib.Accounts.get(id)
      account
    else
      nil
    end
  end

  @spec logged_in? :: boolean()
  def logged_in? do
    Agent.get(:logged_in)
  end
end
