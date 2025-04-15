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

  @doc "Resolver function for creating seasons"
  def create_season(_parent, args, _resolution) do
    case Seasons.create(args) do
      {:error, cs} -> Result.error("Failed to create season", cs)
      result -> result
    end
  end

  @doc "Resolver function for updating season name"
  def update_season(_parent, %{id: id, name: name}, _resolution) do
    case Seasons.get(id) do
      nil -> Result.error("Season not found: #{id}")
      season -> update_season(season, name)
    end
  end

  # Update season helper
  defp update_season(season, name) do
    case Seasons.update(season, %{name: name}) do
      {:error, cs} -> Result.error("Failed to update season", cs)
      result -> result
    end
  end

  @doc "Resolver function for deleting seasons"
  def delete_season(_parent, %{id: id}, _resolution) do
    case Seasons.get(id) do
      nil -> Result.error("Season not found: #{id}")
      season -> Seasons.delete(season)
    end
  end
end
