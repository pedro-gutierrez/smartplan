import Config

if config_env() != :test do
  config :logger,
    level: System.get_env("LOG_LEVEL", "info") |> String.to_existing_atom()

  config :smartplan, Smartplan.Repo, database: "smartplan"
end
