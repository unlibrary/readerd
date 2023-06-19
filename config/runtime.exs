# default config file for readerd
import Config

config :unlib, UnLib.Repo,
  hostname: "localhost",
  username: "postgres",
  password: "postgres"

config :unlibd,
  autopull: false,
  interval: :timer.minutes(30)

config :unlib,
  pull_in_async: true,
  pre_pull_hook: &UnLibD.Logger.info("Pulling #{&1.name} (#{&1.url})"),
  post_pull_hook: &UnLibD.Logger.success("Finished #{&1.name} (#{&1.url})")
