defmodule UnLibD.Auth do
  @moduledoc """
  Handles user authentication.
  """

  alias UnLibD.Agent

  @spec login(String.t(), String.t()) :: :ok
  def login(username, password) do
    case UnLib.Accounts.login(username, password) do
      {:ok, account} -> Agent.put(account)
      {:error, error} -> error
    end
  end

  @spec logout :: :ok
  def logout do
    Agent.put(:logout)
  end

  @spec current_user :: UnLib.Account.t()
  def current_user do
    Agent.get(:user)
  end

  @spec logged_in? :: boolean()
  def logged_in? do
    Agent.get(:logged_in)
  end

  @spec refresh :: :ok
  def refresh do
    {:ok, account} = UnLib.Accounts.get(current_user().id)
    Agent.put(account)
  end

  @spec refresh(UnLib.Account.t()) :: :ok
  def refresh(account) do
    if account.id == current_user().id do
      Agent.put(account)
    end
  end
end
