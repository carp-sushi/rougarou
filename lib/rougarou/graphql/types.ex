defmodule Rougarou.GraphQL.Types do
  @moduledoc """
  GraphQL schema type definitions.
  """
  use Absinthe.Schema.Notation

  import Absinthe.Resolution.Helpers, only: [dataloader: 1]

  alias Rougarou.Context.Leagues
  alias Rougarou.Context.Seasons
  alias Rougarou.Context.Teams

  @desc "A league is a level of play"
  object :league do
    field(:id, :id)
    field(:name, :string)
    field(:level, :string)
  end

  @desc "A season is a date range in which games are played"
  object :season do
    field(:id, :id)
    field(:name, :string)
    field(:start_date, :date)
    field(:end_date, :date)
  end

  @desc "A player is a person on a team"
  object :player do
    field(:id, :id)
    field(:name, :string)
    field(:contact, :string)
    field(:usahn, :string)
    field(:jersey_number, :string)
    field(:position, :string)
    field(:team, :team, resolve: dataloader(Teams))
  end

  @desc "A team is a group of players in a league for a given season"
  object :team do
    field(:id, :id)
    field(:name, :string)
    field(:captain, :string)
    field(:league, :league, resolve: dataloader(Leagues))
    field(:season, :season, resolve: dataloader(Seasons))
    field(:players, list_of(:player), resolve: dataloader(Teams))
  end
end
