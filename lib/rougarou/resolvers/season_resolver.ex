defmodule Rougarou.Resolvers.SeasonResolver do
  @moduledoc """
  GraphQL resolver for seasons.
  """
  alias Rougarou.Context.Seasons
  alias Rougarou.Result

  @doc "Resolve the season with the given ID"
  def get_season(_parent, %{id: id}, _resolution) do
    case Seasons.get(id) do
      nil -> Result.error("Season not found: #{id}")
      season -> Result.success(season)
    end
  end

  @doc "Resolve a page of seasons"
  def list_seasons(_parent, %{first: first, offset: offset}, _resolution) do
    Result.success(Seasons.list(first, offset))
  end

  def list_seasons(_parent, %{first: first}, _resolution) do
    Result.success(Seasons.list(first))
  end

  def list_seasons(_parent, _args, _resolution) do
    Result.success(Seasons.first_page())
  end
end
