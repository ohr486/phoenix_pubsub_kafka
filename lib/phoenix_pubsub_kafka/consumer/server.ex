defmodule Phoenix.PubSub.Kafka.Consumer.Server do
  use KafkaEx.GenConsumer
  #require Logger
  alias KafkaEx.Protocol.Fetch.Message
  alias Phoenix.PubSub.Local
  alias Phoenix.PubSub.Kafka.Config

  def handle_message_set(message_set, state) do
    #Logger.debug "### Phoenix.PubSub.Kafka.Consumer.Server.hanndle_message_set(#{inspect message_set}, #{inspect state}) ###"
    for %Message{value: message} <- message_set do
      #Logger.debug(fn -> "message: " <> inspect(message) end)

      {remote_node_ref, fastlane, pool_size, from_pid, phx_topic, msg} = Config.serializer.decode_message(message)
      #Logger.debug "-------------------------------"
      #Logger.debug "# remote_node_ref: #{inspect remote_node_ref} #"
      #Logger.debug "# fastlane: #{inspect fastlane} #"
      #Logger.debug "# pool_size: #{inspect pool_size} #"
      #Logger.debug "# from_pid: #{inspect from_pid} #"
      #Logger.debug "# phx_topic: #{inspect phx_topic} #"
      #Logger.debug "# msg: #{inspect msg} #"
      #Logger.debug "-------------------------------"

      Local.broadcast(fastlane, ChatBackend.PubSub, 1, from_pid, phx_topic, msg)
    end
    {:async_commit, state}
  end
end
