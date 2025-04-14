defmodule Rougarou.Plug do
  @moduledoc """
  GraphQL router
  """
  use Plug.Router

  if Mix.env() == :dev do
    use Plug.Debugger, otp_app: :dapp
  end

  @uri_base Application.compile_env(:rougarou, :uri_base)

  plug(Plug.Logger, log: :debug)
  plug(CORSPlug)
  plug(:match)

  # Use the Jason library for JSON parsing
  plug(Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json, Absinthe.Plug.Parser],
    pass: ["*/*"],
    json_decoder: Jason
  )

  plug(:dispatch)

  # Main GraphQL api route
  forward(
    "#{@uri_base}/graphql",
    to: Absinthe.Plug,
    init_opts: [schema: Rougarou.GraphQL.Schema, analyze_complexity: true, max_complexity: 50]
  )

  # Only show the GraphiQL user interface in the development environment
  if Mix.env() == :dev do
    forward(
      "#{@uri_base}/graphiql",
      to: Absinthe.Plug.GraphiQL,
      init_opts: [schema: Rougarou.GraphQL.Schema, analyze_complexity: true, max_complexity: 180]
    )
  end

  # Catch-all returns not-found errors.
  match _ do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(404, Jason.encode!(%{errors: [%{message: "route not found"}]}))
    |> halt()
  end
end
