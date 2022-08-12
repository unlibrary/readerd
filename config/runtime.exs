# default config file for readerd
import Config

config :unlib, UnLib.Repo,
  hostname: "localhost",
  username: "postgres",
  password: "postgres"

config :unlibd,
  autopull: true,
  interval: :timer.minutes(2)
