defmodule UnLibD.Auth do
  @moduledoc """
  Handles user authentication.
  """

  alias UnLibD.Agent

  @spec login(String.t(), String.t()) ::
          {:ok, UnLib.Account.t()} | {:error, :no_user_found | :invalid_password}
  def login(username, password) do
    case UnLib.Accounts.login(username, password) do
      {:ok, account} ->
        Agent.put(account.id)
        {:ok, account}

      {:error, error} ->
        {:error, error}
    end
  end

  @spec logout() :: :ok
  def logout do
    Agent.put(:logout)
  end

  @spec current_user() :: UnLib.Account.t() | nil
  def current_user do
    if user_id = Agent.get(:user_id) do
      case UnLib.Accounts.get(user_id) do
        {:ok, user} -> user
        {:error, _error} -> nil
      end
    end
  end

  @spec logged_in?() :: boolean()
  def logged_in? do
    Agent.get(:logged_in)
  end
end
