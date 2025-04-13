defmodule Rougarou.Resolvers.PlayerResolver do
  @moduledoc """
  GraphQL resolver for players.
  """
  alias Rougarou.Context.Players
  alias Rougarou.Result

  @doc "Resolve the player with the given ID"
  def get_player(_parent, %{id: id}, _resolution) do
    case Players.get(id) do
      nil -> Result.error("Player not found: #{id}")
      player -> Result.success(player)
    end
  end

  @doc "Resolve all players on a team"
  def list_players(_parent, %{team_id: team_id}, _resolution) do
    Result.success(Players.on_team(team_id))
  end
end
