defmodule Smartplan.Router do
  @moduledoc false
  use Plug.Router

  plug(Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json, Absinthe.Plug.Parser],
    pass: ["*/*"],
    json_decoder: Jason
  )

  plug(:match)
  plug(Smartplan.Auth)
  plug(:dispatch)

  forward("/api", to: Smartplan.Schema.Router)

  if Mix.env() == :dev do
    get("/doc", to: Smartplan.Schema.RedocUI, init_opts: [spec_url: "/api/openapi.json"])
  end

  get "/health" do
    send_resp(conn, 200, "")
  end

  match _ do
    send_resp(conn, 404, "")
  end
end
