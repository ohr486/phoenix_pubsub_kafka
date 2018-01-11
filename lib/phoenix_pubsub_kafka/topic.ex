defmodule Phoenix.PubSub.Kafka.Topic do
  alias Phoenix.PubSub.Kafka.Config

  def phoenix_topic_to_kafka_topic(topic) do
    # TODO: change configuable
    conv_func = fn t -> t |> String.split(":") |> List.first end
    conv_func().(topic)
    |> replace_invalid_chars
    |> add_prefix
  end

  def add_prefix(topic) do
    "#{Config.topic_prefix()}#{topic}"
  end

  def replace_invalid_chars(topic) do
    Config.invalid_topic_chars()
    |> Enum.map_reduce(topic, fn x, acc ->
      {elem(x, 0), String.replace(acc, elem(x, 0), elem(x, 1))}
    end)
    |> elem(1)
  end
end
