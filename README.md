# PhoenixPubSubKafka

Kafka adapter for Phoenix's PubSub layer.

## Installation

[![Build Status](https://travis-ci.org/ohr486/phoenix_pubsub_kafka.svg?branch=master)](https://travis-ci.org/ohr486/phoenix_pubsub_kafka)

[![CircleCI](https://circleci.com/gh/ohr486/phoenix_pubsub_kafka/tree/master.svg?style=svg)](https://circleci.com/gh/ohr486/phoenix_pubsub_kafka/tree/master)

[![Coverage Status](https://coveralls.io/repos/github/ohr486/phoenix_pubsub_kafka/badge.svg?branch=master)](https://coveralls.io/github/ohr486/phoenix_pubsub_kafka?branch=master)

by adding `phoenix_pubsub_kafka` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:phoenix_pubsub_kafka, github: "ohr486/phoenix_pubsub_kafka", branch: "master"}
  ]
end
```

and, add kafka settings in `config/config.exs`

```elixir
config :phoenix_pubsub_kafka,
  debug: false,
  pubsub_name: YourApp.PubSub,
  topic_prefix: <your_topic_prefix>,
  listening_topics: [<your_topic1>, <your_topic2>, ...],
  consumer_group_name: <your_consumer_group_name>

config :kafka_ex,
  brokers: [
    <broker1 endpoint>,
    <broker2 endpoint>,
    ...
  ],
  consumer_group: :no_consumer_group,
  disable_default_worker: false,
  sync_timeout: 60_000,
  max_seconds: 60,
  commit_interval: 5_000,
  commit_threshold: 100,
  use_ssl: false,
  pause_before_crash_msec: 1000
```
