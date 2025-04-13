defmodule Rougarou.Context.Players do
  @moduledoc """
  A data context for managing players.
  """
  import Ecto.Query

  alias Rougarou.Repo
  alias Rougarou.Schema.Player

  @doc "Get a player"
  def get(id), do: Repo.get(Player, id)

  @doc "Get the list of players on a team"
  def on_team(team_id) do
    Player
    |> where(team_id: ^team_id)
    |> Repo.all()
  end
end
