defmodule Phoenix.PubSub.Kafka.Consumer.Server do
  use KafkaEx.GenConsumer
  alias KafkaEx.Protocol.Fetch.Message
  alias Phoenix.PubSub.Local
  alias Phoenix.PubSub.Kafka.Config

  def handle_message_set(message_set, state) do
    for %Message{value: message} <- message_set do
      {remote_node_ref, fastlane, pool_size, from_pid, phx_topic, msg} = Config.serializer.decode_message(message)
      Local.broadcast(fastlane, ChatBackend.PubSub, 1, from_pid, phx_topic, msg)
    end
    {:async_commit, state}
  end
end
