defmodule Smartplan.Auth do
  @moduledoc false
  @behaviour Plug
  import Plug.Conn

  @impl true
  def init(opts), do: opts

  @impl true
  def call(conn, _opts) do
    assign(conn, :current_user, %{roles: [:user]})
  end
end
