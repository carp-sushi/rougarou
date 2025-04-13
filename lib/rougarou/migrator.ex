defmodule Rougarou.Migrator do
  @moduledoc """
  Runs ecto migrations.
  """
  require Application

  def run do
    {:ok, _} = Application.ensure_all_started(:rougarou)
    path = Application.app_dir(:rougarou, "priv/repo/migrations")
    Ecto.Migrator.run(Rougarou.Repo, path, :up, all: true)
    :init.stop()
  end
end
