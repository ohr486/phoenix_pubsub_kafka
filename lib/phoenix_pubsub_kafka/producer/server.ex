defmodule Phoenix.PubSub.Kafka.Producer.Server do
  use GenServer
  alias Phoenix.PubSub.Local
  alias Phoenix.PubSub.Kafka.Topic
  alias Phoenix.PubSub.Kafka.Config

  def start_link(name, opts) do
    GenServer.start_link(__MODULE__, [name, opts], name: name)
  end

  def init([name, opts]) do
    Process.flag(:trap_exit, true)
    {:ok, %{}}
  end

  def broadcast(fastlane, pool_size, node_ref, from_pid, topic, payload) do
    do_broadcast(fastlane, pool_size, node_ref, from_pid, topic, payload)
  end

  def direct_broadcast(arg) do
    # TODO: impl it
  end

  defp do_broadcast(fastlane, pool_size, node_ref, from_pid, phx_topic, payload) do
    kafka_msg = {node_ref, fastlane, pool_size, from_pid, phx_topic, payload}
    partition = 0
    required_acks = 1

    {:ok, seq} = %KafkaEx.Protocol.Produce.Request{
                   topic: Topic.phoenix_topic_to_kafka_topic(phx_topic),
                   partition: partition,
                   required_acks: required_acks,
                   messages: [%KafkaEx.Protocol.Produce.Message{value: Config.serializer.encode_message(kafka_msg)}]
                 }
                 |> KafkaEx.produce

    :ok
  end
end
