defmodule Rougarou.GraphQL.Schema do
  @moduledoc """
  The GraphQL schema.
  """
  use Absinthe.Schema

  alias Rougarou.Context.Leagues
  alias Rougarou.Context.Seasons
  alias Rougarou.Context.Teams
  alias Rougarou.Resolvers.LeagueResolver
  alias Rougarou.Resolvers.PlayerResolver
  alias Rougarou.Resolvers.SeasonResolver
  alias Rougarou.Resolvers.TeamResolver

  import_types(Absinthe.Type.Custom)
  import_types(Rougarou.GraphQL.Types)

  query do
    @desc "Get a league"
    field :league, :league do
      arg(:id, non_null(:id))
      resolve(&LeagueResolver.get_league/3)
    end

    @desc "List leagues"
    field :leagues, list_of(:league) do
      arg(:first, :integer)
      arg(:offset, :integer)
      resolve(&LeagueResolver.list_leagues/3)
    end

    @desc "Get a season"
    field :season, :season do
      arg(:id, non_null(:id))
      resolve(&SeasonResolver.get_season/3)
    end

    @desc "List seasons"
    field :seasons, list_of(:season) do
      arg(:first, :integer)
      arg(:offset, :integer)
      resolve(&SeasonResolver.list_seasons/3)
    end

    @desc "Get a team"
    field :team, :team do
      arg(:id, non_null(:id))
      resolve(&TeamResolver.get_team/3)
    end

    @desc "List teams"
    field :teams, list_of(:team) do
      arg(:season_id, non_null(:id))
      arg(:league_id, :id)
      resolve(&TeamResolver.list_teams/3)
    end

    @desc "Get a player"
    field :player, :player do
      arg(:id, non_null(:id))
      resolve(&PlayerResolver.get_player/3)
    end

    @desc "List players on a team"
    field :players, list_of(:player) do
      arg(:team_id, non_null(:id))
      resolve(&PlayerResolver.list_players/3)
    end
  end

  mutation do
    @desc "Create a season"
    field :create_season, :season do
      arg(:name, non_null(:string))
      arg(:start_date, non_null(:date))
      arg(:end_date, non_null(:date))
      resolve(&SeasonResolver.create_season/3)
    end

    @desc "Rename a season"
    field :rename_season, :season do
      arg(:id, non_null(:id))
      arg(:name, non_null(:string))
      resolve(&SeasonResolver.update_season/3)
    end

    @desc "Delete a season"
    field :delete_season, :season do
      arg(:id, non_null(:id))
      resolve(&SeasonResolver.delete_season/3)
    end
  end

  # Dataloader

  def context(ctx) do
    loader =
      Dataloader.new()
      |> Dataloader.add_source(Leagues, Leagues.datasource())
      |> Dataloader.add_source(Seasons, Seasons.datasource())
      |> Dataloader.add_source(Teams, Teams.datasource())

    Map.put(ctx, :loader, loader)
  end

  def plugins do
    [Absinthe.Middleware.Dataloader] ++ Absinthe.Plugin.defaults()
  end
end
