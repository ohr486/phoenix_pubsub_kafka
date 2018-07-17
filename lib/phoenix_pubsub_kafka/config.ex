defmodule Phoenix.PubSub.Kafka.Config do
  alias Phoenix.PubSub.Kafka.Serializer
  alias Phoenix.PubSub.Kafka.Topic

  @invalid_topic_chars %{
    ":" => "-rep1-",
    "#" => "-rep2-",
    "$" => "-rep3-"
  }

  def serializer do
    Application.get_env(:phoenix_pubsub_kafka, :serializer) || Serializer.Binary
  end

  def invalid_topic_chars do
    diff = Application.get_env(:phoenix_pubsub_kafka, :invalid_topic_chars) || %{}
    Map.merge(@invalid_topic_chars, diff)
  end

  def topic_prefix do
    Application.get_env(:phoenix_pubsub_kafka, :topic_prefix) || ""
  end

  def topic_convert_func do
    Application.get_env(:phoenix_pubsub_kafka, :topic_convert_func) || &(&1)
  end

  def listening_topics do
    topics = Application.get_env(:phoenix_pubsub_kafka, :listening_topics) || raise "set listening topics"
    Enum.map(topics, fn topic ->
      topic
      |> Topic.replace_invalid_chars
      |> Topic.add_prefix
    end)
  end

  def consumer_group_name do
    Application.get_env(:phoenix_pubsub_kafka, :consumer_group_name) || "phx_ps_kfk"
  end

  def restart_interval do
    Application.get_env(:phoenix_pubsub_kafka, :restart_intarval) || 5000
  end

  def restart_count_threshold do
    Application.get_env(:phoenix_pubsub_kafka, :restart_count_threshold) || 2
  end
end
