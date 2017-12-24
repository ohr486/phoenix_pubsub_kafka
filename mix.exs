defmodule PhoenixPubsubKafka.Mixfile do
  use Mix.Project

  @version "0.0.1"

  def project do
    [
      app: :phoenix_pubsub_kafka,
      version: @version,
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      deps: deps()
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
      {:ex_doc, "~> 0.17.1", only: :docs}
    ]
  end
end
