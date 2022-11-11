defmodule Smartplan.Port do
  @moduledoc false

  def child_spec(_) do
    Plug.Cowboy.child_spec(
      scheme: :http,
      plug: Smartplan.Router,
      options: [port: System.get_env("PORT", "4001") |> String.to_integer()]
    )
  end
end
