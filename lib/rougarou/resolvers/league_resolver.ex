defmodule Rougarou.Resolvers.LeagueResolver do
  @moduledoc """
  GraphQL resolver for leagues.
  """
  alias Rougarou.Context.Leagues
  alias Rougarou.Result

  @doc "Resolve the league with the given ID"
  def get_league(_parent, %{id: id}, _resolution) do
    case Leagues.get(id) do
      nil -> Result.error("League not found: #{id}")
      league -> Result.success(league)
    end
  end

  @doc "Resolve a page of leagues"
  def list_leagues(_parent, %{first: first, offset: offset}, _resolution) do
    Result.success(Leagues.list(first, offset))
  end

  def list_leagues(_parent, %{first: first}, _resolution) do
    Result.success(Leagues.list(first))
  end

  def list_leagues(_parent, _args, _resolution) do
    Result.success(Leagues.first_page())
  end
end
