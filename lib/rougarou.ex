defmodule Rougarou do
  @moduledoc """
  The application entry point.
  """
  use Application

  require Logger

  @port Application.compile_env(:rougarou, :http_port, 8080)

  @impl true
  def start(_type, _args) do
    Logger.info("Running on port #{@port}")
    children = [Rougarou.Repo, {Bandit, plug: Rougarou.Plug, port: @port}]
    Supervisor.start_link(children, strategy: :one_for_one, name: Rougarou.Supervisor)
  end
end
