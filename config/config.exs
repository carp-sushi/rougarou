import Config

# Customize alphabet for nanoid primary keys
config :nanoid,
  size: 21,
  alphabet: "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"

# Repos
config :rougarou,
  ecto_repos: [Rougarou.Repo]

# Base compile time config
config :rougarou,
  http_port: 8088,
  min_page_size: 10,
  max_page_size: 100,
  uri_base: "/rougarou"

# Load environment specific config
import_config "#{config_env()}.exs"
