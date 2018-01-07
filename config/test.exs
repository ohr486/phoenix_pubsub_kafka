use Mix.Config

config :kafka_ex,
  brokers: [],
  consumer_group: "phx_pubsub_kafka_test",
  disable_default_worker: true
