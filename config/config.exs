import Config

config :smartplan, ecto_repos: [Smartplan.Repo]
config :graphism, schema: Smartplan.Schema

if config_env() == :test do
  config :logger, level: :warn

  config :smartplan, Smartplan.Repo,
    database: "smartplan_test",
    username: "smartplan",
    password: "smartplan",
    pool: Ecto.Adapters.SQL.Sandbox
end
