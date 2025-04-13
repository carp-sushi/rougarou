defmodule Rougarou.Context.Teams do
  @moduledoc """
  A data context for managing teams.
  """
  import Ecto.Query

  alias Rougarou.Repo
  alias Rougarou.Schema.Team

  require Logger

  # Put a max limit on any list queries
  @query_limit Application.compile_env(:rougarou, :max_page_size)

  @doc "Get a team"
  def get(id), do: Repo.get(Team, id)

  @doc "Get teams for a season"
  def list(season_id) do
    Team
    |> where(season_id: ^season_id)
    |> limit(^@query_limit)
    |> Repo.all()
  end

  @doc "Get teams for a season in a league"
  def list(season_id, league_id) do
    Team
    |> where(season_id: ^season_id)
    |> where(league_id: ^league_id)
    |> limit(^@query_limit)
    |> Repo.all()
  end

  @doc "Defines a new ecto data source"
  def datasource, do: Dataloader.Ecto.new(Repo, query: &query/2)

  @doc "An example dataloader query function."
  def query(queriable, args) do
    Logger.debug("Teams.query, args = #{inspect(args)}")
    queriable
  end
end
