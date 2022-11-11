defmodule Smartplan.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      Smartplan.Repo,
      Smartplan.Port
    ]

    opts = [strategy: :one_for_one, name: Smartplan.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
