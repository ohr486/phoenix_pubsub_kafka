defmodule Phoenix.PubSub.Kafka.Producer.Server do
  @moduledoc nil

  use GenServer
  alias Phoenix.PubSub.Kafka.{Config, Klogger, Topic}

  def start_link(name, opts) do
    Klogger.debug("Producer.Server.start_link(#{inspect name}, #{inspect opts})")
    GenServer.start_link(__MODULE__, [name, opts], name: name)
  end

  def init([name, opts]) do
    Klogger.debug("Producer.Server.init([#{inspect name}, #{inspect opts}])")
    Process.flag(:trap_exit, true)
    {:ok, %{}}
  end

  # TODO: Function takes too many parameters
  def broadcast(fastlane, pool_size, node_ref, from_pid, topic, payload) do
    Klogger.debug("Producer.Server.do_broadcast(#{inspect fastlane},#{inspect pool_size},#{inspect node_ref},#{inspect from_pid},#{inspect topic},#{inspect payload})")
    do_broadcast(fastlane, pool_size, node_ref, from_pid, topic, payload)
  end

  def direct_broadcast(arg) do
    # TODO: imple it
    Klogger.debug("TODO: imple Producer.Server.direct_broadcast(#{inspect arg})")
  end

  # TODO: Function takes too many parameters
  defp do_broadcast(fastlane, pool_size, node_ref, from_pid, phx_topic, payload) do
    Klogger.debug("Producer.Server.do_broadcast(#{inspect fastlane},#{inspect pool_size},#{inspect node_ref},#{inspect from_pid},#{inspect phx_topic},#{inspect payload})")
    kafka_msg = {node_ref, fastlane, pool_size, from_pid, phx_topic, payload}
    partition = 0 # TODO: config
    required_acks = 1 # TODO: use config

    {:ok, _seq} = %KafkaEx.Protocol.Produce.Request{
                    topic: Topic.phoenix_topic_to_kafka_topic(phx_topic),
                    partition: partition,
                    required_acks: required_acks,
                    messages: [
                      %KafkaEx.Protocol.Produce.Message{
                        value: Config.serializer.encode_message(kafka_msg)
                      }
                    ]
                  }
                  |> KafkaEx.produce

    :ok
  end
end
