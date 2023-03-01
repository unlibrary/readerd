defmodule UnLibD.Auth do
  @moduledoc """
  Handles user authentication.
  """

  alias UnLibD.Agent

  @spec login(String.t(), String.t()) ::
          :ok | {:error, :no_user_found | :invalid_password}
  def login(username, password) do
    case UnLib.Accounts.login(username, password) do
      {:ok, account} -> Agent.put(account.id)
      {:error, error} -> {:error, error}
    end
  end

  @spec logout() :: :ok
  def logout do
    Agent.put(:logout)
  end

  @spec current_user() :: UnLib.Account.t() | nil
  def current_user do
    Agent.get(:user)
  end

  @spec logged_in?() :: boolean()
  def logged_in? do
    Agent.get(:logged_in)
  end
end
