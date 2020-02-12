use Mix.Config

config :elixir, ansi_enabled: true

config :unicli, UniCLI.Controller,
  profile: {:system, "UNIFI_PROFILE", "default"},
  host: {:system, "UNIFI_HOST", "https://10.9.6.8:8443"},
  username: {:system, "UNIFI_USERNAME", "manager"},
  password: {:system, "UNIFI_PASSWORD", "fr0ggy"}
