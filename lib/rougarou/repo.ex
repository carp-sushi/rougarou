defmodule Rougarou.Repo do
  @moduledoc false
  use Ecto.Repo,
    otp_app: :rougarou,
    adapter: Ecto.Adapters.Postgres
end
