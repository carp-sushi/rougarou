defmodule Rougarou.Result do
  @moduledoc """
  Success and error helper functions
  """
  alias Rougarou.Error

  @doc "Resolution success"
  def success(value) do
    {:ok, value}
  end

  @doc "Resolution failue"
  def error(message), do: Error.new(message)
  def error(message, changeset), do: Error.new(message, changeset)
end
