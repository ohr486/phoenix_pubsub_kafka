defmodule Phoenix.PubSub.Kafka.Consumer.Server do
  @moduledoc nil

  use KafkaEx.GenConsumer
  alias KafkaEx.Protocol.Fetch.Message
  alias Phoenix.PubSub.Local
  alias Phoenix.PubSub.Kafka.{Config, Klogger}

  def handle_message_set(message_set, state) do
    Klogger.debug("Consumer.Server.handle_message_set(#{inspect message_set}, #{inspect state})")
    for %Message{value: message} <- message_set do
      {_remote_node_ref, fastlane, pool_size, from_pid, phx_topic, msg} =
        Config.serializer.decode_message(message)

      Local.broadcast(
        fastlane, Config.pubsub_name(), pool_size,
        from_pid, phx_topic, msg
      )
    end
    {:async_commit, state}
  end
end
