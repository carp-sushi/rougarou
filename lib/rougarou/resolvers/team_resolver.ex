defmodule Rougarou.Resolvers.TeamResolver do
  @moduledoc """
  GraphQL resolver for teams.
  """
  alias Rougarou.Context.Teams
  alias Rougarou.Result

  @doc "Resolve the team with the given ID"
  def get_team(_parent, %{id: id}, _resolution) do
    case Teams.get(id) do
      nil -> Result.error("Team not found: #{id}")
      team -> Result.success(team)
    end
  end

  @doc "Resolve a page of teams"
  def list_teams(_parent, %{season_id: season_id, league_id: league_id}, _resolution) do
    Result.success(Teams.list(season_id, league_id))
  end

  def list_teams(_parent, %{season_id: season_id}, _resolution) do
    Result.success(Teams.list(season_id))
  end
end
