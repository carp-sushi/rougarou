defmodule Rougarou.Schema.Season do
  @moduledoc """
  Ecto schema for the `seasons` table.
  """
  use Ecto.Schema

  import Ecto.Changeset

  @type t() :: %__MODULE__{}

  @primary_key {:id, :string, autogenerate: {Ecto.Nanoid, :autogenerate, []}}
  schema "seasons" do
    field(:name, :string)
    field(:start_date, :date)
    field(:end_date, :date)
    timestamps()
  end

  @doc "Creates a changeset for a season"
  def changeset(struct, params) do
    struct
    |> cast(params, [:name, :start_date, :end_date])
    |> validate_required([:name, :start_date, :end_date])
    |> validate_length(:name, max: 100)
  end

  def changeset(params),
    do: changeset(%__MODULE__{}, params)
end
