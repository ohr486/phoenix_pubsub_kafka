defmodule PhoenixPubSubKafka.Mixfile do
  use Mix.Project

  @version "0.0.2"

  def project do
    [
      app: :phoenix_pubsub_kafka,
      version: @version,
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      dialyzer: [
        plt_add_deps: :transitive,
        flags: [
          :error_handling,
          :race_connditions
        ]
      ],
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [coveralls: :test, "coveralls.detail": :test, "coveralls.post": :test, "coveralls.html": :test],
      description: description(),
      package: package(),
      deps: deps(),
      aliases: aliases()
    ]
  end

  def application do
    [
      extra_applications: [:logger, :kafka_ex, :phoenix_pubsub]
    ]
  end

  defp deps do
    [
      {:phoenix_pubsub, "~> 1.0"},
      {:kafka_ex, "~> 0.8.1"},
      {:credo, "~> 0.8.10", only: :dev},
      {:dialyxir, "~> 0.5.1", only: :dev},
      {:excoveralls, "~> 0.10", only: :test},
      {:ex_doc, "~> 0.17.1", only: :docs}
    ]
  end

  defp description do
    "Kafka adapter for Phoenix's PubSub layer."
  end

  defp package do
    [
      maintainers: ["ohr486"],
      files: ["lib", "config/config.exs", "mix.exs", "README.md"],
      licenses: ["MIT"],
      links: %{"Github" => "https://github.com/ohr486/phoenix_pubsub_kafka"}
    ]
  end

  defp aliases do
    [
      lint: ["credo --strict"]
    ]
  end
end
